<?php

namespace App\Http\Controllers;

use App\Http\Requests\OfferItemRequest;
use App\Http\Requests\OfferRequest;
use App\Http\Requests\OfferUpdateRequest;
use App\Http\Requests\OfferMealRequest;
use App\Http\Requests\OfferExtraRequest;
use App\Http\Requests\OfferAddonRequest;

use App\Models\Addon;
use App\Models\ExpiredOffer;
use App\Models\Extra;
use App\Models\Meal;
use App\Models\Offer;
use App\Models\Offer_item;
use App\Models\Transaction;
use App\Models\Offer_meal;
use App\Models\Offer_extra;
use App\Models\Offer_addon;

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

    public function show($id)
    {
        $offer = Offer::find($id);

        if (!$offer) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Offer not found'
            ], 404);
        }

        $offerItems = [
            'id' => $offer->id,
            'name' => $offer->name,
            'discount' => $offer->discount,
            'status' => $offer->status,
            'start_date' => $offer->startDate,
            'end_date' => $offer->endDate
        ];

        return response()->json([
            'status' => 'success',
            'Items' => $offerItems
        ], 200);
    }

    // all items the found offer
    public function items()
    {
        try {
            $offers = Offer::where('status', '1')->with(['addons', 'meals', 'extras'])->get();

            // Format each offer using the getOffer method in the Offer model
            $formattedOffers = $offers->map(function ($offer) {
                return $offer->getOffer(); // Call the getOffer method on each offer instance
            });    
            // $formattedOffers =
                // return [
                //     'id' => $offer->id,
                //     'name' => $offer->name,
                //     'discount' => $offer->discount,
                //     'image' => $offer->image,
                //     'status' => $offer->status,
                //     'addons' => $offer->addons->map(function ($addon) {
                //         return [
                //             'addon_id' => $addon->addon_id,
                //             'addon_quantity' => $addon->addon_quantity,
                            
                //         ];
                //     }),
                //     'meals' => $offer->meals, 
                //     'extras' => $offer->extras, 
                // ];
            
                $formattedOffers = $offers->map(function ($offer) {
                    return $offer->getOffer(); // Call the getOffer method on each offer instance
                });
            return response()->json([
                'status' => 'success',
                'data' => $formattedOffers
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Failed to retrieve offers: ' . $e->getMessage()
            ], 500);
        }
    }
    
    


    


    /**
     * Display a listing of the resource.
     */
    //fetch all index
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

    // fetch all indexClient
    public function indexClient()
    {
        $offers = Offer::query()->with(['extras', 'meals', 'addons']);

        $offers->where('status', true);
        
        $offers = $offers->get();
        $offersData = $offers->map(function ($offer) {
            return [
                'id' => $offer->id,
                'name' => $offer->name,
                'discount' => $offer->discount,
                'status' => $offer->status,
                'start_date' => $offer->startDate,
                'end_date' => $offer->endDate,
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
    // public function store(OfferRequest $request)
    // {

    //     $imagePath = $this->handleImageUpload($request);
        
    //     $offer = Offer::create([
    //         'name' => $request->validated('name'),
    //         'discount' => $request->validated('discount'),
    //         'startDate' => $request->validated('startDate'),
    //         'endDate' => $request->validated('endDate'),
    //         'status' => $request->validated('status'),
    //         'image' => $imagePath
    //     ]);
    //     if (!$offer)
    //         return response()->json([
    //             'status' => 'failed',
    //             'message' => 'internal server error'
    //         ], 500);
    //     ExpiredOffer::create([
    //         'offer_id' => $offer->id,
    //         'expired_Date' => $offer->endDate
    //     ], 201);
    //     return response()->json([
    //         'status' => 'success',
    //         'message' => 'added Offer successfully'
    //     ], 201);
    // }

    public function store(OfferRequest $request)
    {
        DB::beginTransaction();
    
        try {
            $startDate = \Carbon\Carbon::createFromFormat('d-m-Y H:i', $request->validated('startDate'))->format('Y-m-d H:i');
            $endDate = \Carbon\Carbon::createFromFormat('d-m-Y H:i', $request->validated('endDate'))->format('Y-m-d H:i');
            
            $imagePath = $this->handleImageUpload($request);
    
            // Create the offer
            $offer = Offer::create([
                'name' => $request->validated('name'),
                'discount' => $request->validated('discount'),
                'startDate' => $startDate,
                'endDate' => $endDate,
                'status' => $request->validated('status'),
                'image' => $imagePath
            ]);
    
            // Create ExpiredOffer entry
            ExpiredOffer::create([
                'offer_id' => $offer->id,
                'expired_Date' => $offer->endDate
            ]);
    
            DB::commit();
    
            return response()->json([
                'status' => 'success',
                'message' => 'Offer added successfully'
            ], 201);
    
        } catch (\Exception $e) {
            DB::rollBack();
    
            return response()->json([
                'status' => 'failed',
                'message' => 'Internal server error: ' . $e->getMessage()
            ], 500);
        }
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
    // public function show($id)
    // {
    //     $offer = Offer::find($id);
    //     if (!$offer) return response()->json([
    //         'status' => 'failed',
    //         'message' => 'no offer exist'
    //     ], 404);
    //     return response()->json([
    //         'status' => 'success',
    //         'offer' => $offer
    //     ], 200);
    // }

    public function showOfferItems($id)
    {
        $offerExists = Offer::where('id', $id)->exists();
        
        if (!$offerExists) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Offer ID ' . $id . ' not found.'
            ], 404);
        }

        if (!Auth::guard('admin-api')->check()) {
            $offer = Offer::where('id', $id)->where('status', true)->with(['addons', 'meals', 'extras'])->first();
        } else {
            $offer = Offer::with(['addons', 'meals', 'extras'])->find($id);
        }

        if (!$offer) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Offer ID ' . $id . ' not found.'
            ], 404);
        }

        $formattedOffer = $offer->showOfferItems($id);

        return response()->json([
            'status' => 'success',
            'data' => $formattedOffer
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

    //add meals
    public function storeMeal(OfferMealRequest $request)
    {
        $validatedData = $request->validated();
        $mealId = $validatedData['meal_id'];
        $mealQuantity = $validatedData['meal_quantity'];
        $offerId = $validatedData['offer_id'];
        $mealSize = $validatedData['meal_size']; 
    
        try {
            $existingOfferMeal = Offer_meal::where('offer_id', $offerId)
                ->where('meal_id', $mealId)->where('meal_size',$mealSize)->first();
    
            if ($existingOfferMeal) {
                return response()->json([
                    'status' => 'failed',
                    'message' => 'This meal is already associated with the offer.'
                ], 409);
            }
    
            $offerMeal = Offer_meal::create([
                'offer_id' => $offerId,
                'meal_id' => $mealId,
                'meal_quantity' => $mealQuantity,
                'meal_size' => $mealSize
            ]);
    
            return response()->json([
                'status' => 'success',
                'message' => 'Meal added to offer successfully',
                'data' => $offerMeal
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Failed to add meal to offer: ' . $e->getMessage()
            ], 500);
        }
    }
    
    //add extra
    public function storeExtra(OfferExtraRequest $request)
    {
        $validatedData = $request->validated();
        $extraId = $validatedData['extra_id'];
        $extraQuantity = $validatedData['extra_quantity'];
        $offerId = $validatedData['offer_id'];

        try {
            $existingOfferExtra = Offer_extra::where('offer_id', $offerId)
                ->where('extra_id', $extraId)
                ->first();

            if ($existingOfferExtra) {
                return response()->json([
                    'status' => 'failed',
                    'message' => 'This extra is already associated with the offer.'
                ], 409); 
            }

            $offerExtra = Offer_extra::create([
                'offer_id' => $offerId,
                'extra_id' => $extraId,
                'extra_quantity' => $extraQuantity,
            ]);

            return response()->json([
                'status' => 'success',
                'message' => 'Extra added to offer successfully',
                'data' => $offerExtra
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Failed to add extra to offer: ' . $e->getMessage()
            ], 500);
        }
    }

    //add addon
    public function storeAddon(OfferAddonRequest $request)
    {
        $validatedData = $request->validated();
        $addonId = $validatedData['addon_id'];
        $addonQuantity = $validatedData['addon_quantity'];
        $offerId = $validatedData['offer_id'];
    
        try {
            $existingOfferAddon = Offer_addon::where('offer_id', $offerId)
                ->where('addon_id', $addonId)
                ->first();
    
            if ($existingOfferAddon) {
                return response()->json([
                    'status' => 'failed',
                    'message' => 'This addon is already associated with the offer.'
                ], 409); 
            }
    
            $offerMeal = Offer_addon::create([
                'offer_id' => $offerId,
                'addon_id' => $addonId,
                'addon_quantity' => $addonQuantity,
            ]);
    
            return response()->json([
                'status' => 'success',
                'message' => 'Addon added to offer successfully',
                'data' => $offerMeal
            ], 201);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'failed',
                'message' => 'Failed to add addon to offer: ' . $e->getMessage()
            ], 500);
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
