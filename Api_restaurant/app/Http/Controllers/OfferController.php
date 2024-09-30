<?php

namespace App\Http\Controllers;

use App\Http\Requests\OfferItemRequest;
use App\Http\Requests\OfferRequest;
use App\Http\Requests\OfferUpdateRequest;
use App\Models\Addon;
use App\Models\ExpiredOffer;
use App\Models\Extra;
use App\Models\Meal;
use App\Models\Offer;
use App\Models\Offer_item;
use App\Models\Transaction;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

use function PHPUnit\Framework\isEmpty;

class OfferController extends Controller
{


    /**
     * Display items and it's type to front 
     */

    public function getAllItems()
    {

        $items = [

            'meal' => Meal::where('status', 1)->get(),
            'extra' => Extra::where('status', 1)->get(),
            'addon' => Addon::where('status', 1)->get()
        ];
        $emptyCounter = 0;
        foreach ($items as $key => $value) {
            if ($value->isEmpty()) {
                $emptyCounter++;
            }
        }

        if ($emptyCounter == 3) return response()->json([
            'status' => 'failed',
            'message' => 'there is no Items'
        ], 404);
        return response()->json([
            'status' => 'success',
            'Items' => $items
        ], 200);
    }
    /**
     * Display a listing of the Item in the offer
     */
    public function showItems($id)
    {
        // Find the offer by ID with eager loading of relationships
        $offer = Offer::with(['meals', 'addons', 'extras'])->find($id);

        // Check if the offer exists
        if (!$offer) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Offer not found'
            ], 404);
        }

        // Prepare the offer items
        $offerItems = [
            'id' => $offer->id,
            'name' => $offer->name,
            'discount' => $offer->discount,
            'status' => $offer->status,
            'start_date' => $offer->startDate,
            'end_date' => $offer->endDate,
            'extras' => $offer->extras->filter()->values()->map(function ($extra) use ($offer) {
                $quantity = $extra->pivot->extra_quantity ?? null;
                return [
                    'id' => $extra->id,
                    'name' => $extra->name,
                    'quantity' => $quantity,
                    'status' => $extra->status ? 'active' : 'inactive'
                ];
            }),
            'meals' => $offer->meals->filter(function ($meal) {
                return !is_null($meal->name);
            })->values()->map(function ($meal) use ($offer) {
                $smallestPrice = $meal->mealSizeCosts->min('cost');
                $quantity = $meal->pivot->meal_quantity ?? null;
                return [
                    'meal_id' => $meal->id,
                    'meal_name' => $meal->name,
                    'smallest_price' => $smallestPrice,
                    'quantity' => $quantity,
                    'status' => $meal->status ? 'active' : 'inactive'
                ];
            }),
            'addons' => $offer->addons->filter()->values()->map(function ($addon) use ($offer) {
                $quantity = $addon->pivot->addon_quantity ?? null;
                return [
                    'id' => $addon->id,
                    'name' => $addon->name,
                    'quantity' => $quantity,
                    'status' => $addon->status ? 'active' : 'inactive'
                ];
            })
        ];

        return response()->json([
            'status' => 'success',
            'Items' => $offerItems
        ], 200);
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $offers = Offer::query()->with(['extras', 'meals', 'addons']);

        if (!Auth::guard('admin-api')->check()) {
            $offers->where('status', true);
        }
        $offers = $offers->get();
        $offersData = $offers->map(function ($offer) {
            return [
                'id' => $offer->id,
                'name' => $offer->name,
                'discount' => $offer->discount,
                'status' => $offer->status,
                'start_date' => $offer->startDate,
                'end_date' => $offer->endDate,
                'extras' => $offer->extras->isEmpty() ? null : $offer->extras->map(function ($extra) {
                    return [
                        'extra_id' => $extra->id,
                        'extra_name' => $extra->name,
                        'price' => $extra->cost,
                        'status' => $extra->status
                    ];
                }),
                'meals' => $offer->meals->isEmpty() ? null : $offer->meals->map(function ($meal) {
                    // Find the smallest price in the mealSizeCosts relationship
                    $smallestPrice = $meal->mealSizeCosts->min('cost');
                    return [
                        'meal_id' => $meal->id,
                        'meal_name' => $meal->name,
                        'smallest_price' => $smallestPrice,
                        'status' => $meal->status
                    ];
                }),
                'addons' => $offer->addons->isEmpty() ? null : $offer->addons->map(function ($addon) {
                    return [
                        'addon_id' => $addon->id,
                        'addon_name' => $addon->name,
                        'price' => $addon->cost,
                        'status' => $addon->status
                    ];
                })
            ];
        });


        if ($offersData->isEmpty()) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Offers not found'
            ], 404);
        }
        return response()->json([
            'status' => 'success',
            'data' =>  $offersData
        ], 200);
    }


    /**
     * Store a newly created resource in storage.
     */
    public function store(OfferRequest $request)
    {

        $imagePath = $this->handleImageUpload($request);
        
        $offer = Offer::create([
            'name' => $request->validated('name'),
            'discount' => $request->validated('discount'),
            'startDate' => $request->validated('startDate'),
            'endDate' => $request->validated('endDate'),
            'status' => $request->validated('status'),
            'image' => $imagePath
        ]);
        if (!$offer)
            return response()->json([
                'status' => 'failed',
                'message' => 'internal server error'
            ], 500);
        ExpiredOffer::create([
            'offer_id' => $offer->id,
            'expired_Date' => $offer->endDate
        ], 201);
        return response()->json([
            'status' => 'success',
            'message' => 'added Offer successfully'
        ], 201);
    }
    private function handleImageUpload($request)
    {
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = Str::random(40) . '.' . $image->getClientOriginalExtension();
            $directory = 'offers';
            // Ensure the directory exists
            if (!Storage::exists($directory)) {
                Storage::makeDirectory($directory);
            }
            // Store the image and return the path
            $imagePath = $image->storeAs($directory, $imageName, 'public');
            return $imagePath;
        }

        return null;
    }
    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $offer = Offer::find($id);
        if (!$offer) return response()->json([
            'status' => 'failed',
            'message' => 'no offer exist'
        ], 404);
        return response()->json([
            'status' => 'success',
            'offer' => $offer
        ], 200);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Offer $offer)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(OfferUpdateRequest $request,  $id)
    {
        $offer = Offer::find($id);
        if (!$offer) return response()->json([
            'status' => 'failed',
            'message' => 'offer not found'
        ], 404);
        $validatedData = $request->validated();
        if ($request->hasFile('image')) {
            $this->deleteOldImage($offer);
        }
        if ($request->has('endDate')) {
            ExpiredOffer::where('offer_id', $id)->first()->update([
                'expired_Date' => $offer->endDate
            ], 200);
        }
        $validatedData['image'] = $this->handleImageUpload($request);
        $offer->update($validatedData);
        return response()->json([
            'status' => 'success',
            'message' => 'updated done successfully'
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $offer = Offer::find($id);
        if (!$offer) return response()->json([
            'status' => 'failed',
            'message' => 'offer not found'
        ], 404);
        $offer->delete();
        return response()->json([
            'status' => 'success',
            'message' => 'offer deleted successfully'
        ], 200);
    }
    /**
     * Delete Items from offer 
     */
    public function deleteItems($id, $itemId, $type)
    {
        $offer = Offer::find($id);
        if (!$offer) return response()->json([
            'status' => 'failed',
            'message' => 'offer not found'
        ], 404);
        $offerItemQuery = Offer_item::where('offer_id', $id);
        switch ($type) {
            case 'addon':
                $offerItemQuery->where('addon_id', $itemId)->first();
                break;
            case 'meal':
                $offerItemQuery->where('meal_id', $itemId)->first();
                break;
            case 'extra':
                $offerItemQuery->where('extra_id', $itemId)->first();
                break;
            default:
                return response()->json([
                    'status' => 'failed',
                    'message' => 'invalid Type provided'
                ], 400);
        }
        if (!$offerItemQuery) {
            return response()->json([
                'status' => 'failed',
                'message' => 'item not exist'
            ], 404);
        }
        $offerItemQuery->delete();
        return response()->json([
            'status' => 'success',
            'message' => 'Items deleted successfully'
        ], 200);
    }
    /**
     *  Add Items (meals , addons , extras)
     */
    public function addItems(OfferItemRequest $request, $id)
    {
        $offer = Offer::find($id);
        if (!$offer) return response()->json([
            'status' => 'failed',
            'message' => 'offer not found'
        ], 404);

        $validatedData = $request->validated();
        $mealIds = $validatedData['meal_ids'] ?? [];
        $addonIds = $validatedData['addon_ids'] ?? [];
        $extraIds = $validatedData['extra_ids'] ?? [];

        DB::beginTransaction();
        try {
            $offerItem = Offer_item::where('offer_id', $id)->first();
            if (!$offerItem) {
                $offerItem = Offer_item::create([
                    'offer_id' => $id
                ]);
            }

            foreach ($mealIds as $mealId) {
                // dd(Meal::find($mealId['id']));
                $meal =  $this->checkMeal($mealId['id']);
                if ($meal instanceof JsonResponse) return $meal;
                $offerItem->update([
                    'meal_id' => $mealId['id'],
                    'meal_quantity' => $mealId['quantity'],
                ]);
            }
            foreach ($addonIds as $addonId) {
                $addon =  $this->checkAddon($addonId['id']);
                if ($addon instanceof JsonResponse) return $addon;
                $offerItem->update([
                    'addon_id' => $addonId['id'],
                    'addon_quantity' => $addonId['quantity'],
                ]);
            }
            foreach ($extraIds as $extraId) {
                $extra = $this->checkExtra($extraId['id']);
                if ($extra instanceof JsonResponse)
                    return $extra;
                $offerItem->update([
                    'extra_id' => $extraId['id'],
                    'extra_quantity' => $extraId['quantity'],
                ]);
            }
            DB::commit();
            return response()->json([
                'status' => 'success',
                'message' => 'Added Item to offer done successfully'
            ], 201);
        } catch (Exception $e) {
            DB::rollBack();
            return response()->json([
                'status' => 'failed',
                'message' => $e->getMessage()
            ], 400);
        }
    }
    //check for existing addons,meals,extras
    private function checkAddon($id)
    {
        $addon = Addon::find($id);
        if (!$addon) return response()->json([
            'status' => 'failed',
            'message' => 'Addon not found'
        ], 404);
        return $addon;
    }
    private function checkMeal($id)
    {
        $meal = Meal::find($id);
        if (!$meal) return response()->json([
            'status' => 'failed',
            'message' => 'Meal not found'
        ], 404);
        return $meal;
    }
    private function checkExtra($id)
    {
        $extra = Extra::find($id);
        if (!$extra) return response()->json([
            'status' => 'failed',
            'message' => 'Extra not found'
        ], 404);
        return $extra;
    }
    // Helper method to delete old image
    private function deleteOldImage($offer)
    {
        if ($offer->image) {
            Storage::disk('public')->delete($offer->image);
        }
    }
    // get cost after disscount 
    public function getCostAfterDiscount($id, $discount)
    {

        $offerItemQuery = Offer_item::where('offer_id', $id)
            ->with(['extra', 'meal', 'addon']);
        dd($offerItemQuery);

        $totalMealCost = $offerItemQuery->clone()->whereNotNull('meal_id');
        $totalAddonCost = $offerItemQuery->clone()->whereNotNull('addon_id');
        $totalExtraCost = $offerItemQuery->clone()->where('extra_id')->sum('cost');
        $costBeforDiscount = $totalExtraCost + $totalAddonCost + $totalMealCost;
        $costAfterDiscount = $costBeforDiscount - ($costBeforDiscount * $discount);
        dd($costBeforDiscount, $costAfterDiscount);
        return [
            'costBeforDiscount' => $costBeforDiscount,
            'costAfterDiscount' => $costAfterDiscount
        ];
    }
}
