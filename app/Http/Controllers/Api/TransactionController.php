<?php

namespace App\Http\Controllers\Api;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Transaction;
use App\Cart;
use App\Item;
use App\TransactionDetail;

class TransactionController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:api');
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {

        try {
            $user = auth()->user();
            $transactionTable = Transaction::create([
                'user_id' => $user->id,
                'total' => $request->bayar,
                'pay_total' => $request->total
            ]);
            foreach ($request->data as $data) {
                $transactionDetailTable = TransactionDetail::create([
                    'transaction_id' => $transactionTable->id,
                    'item_id' => $data['id'],
                    'quantity' => $data['qty'],
                    'subtotal' => $data['total']
                ]);
            }


            if ($transactionTable && $transactionDetailTable) {
                return response()->json('berhaisl', 200);
            }
        } catch (Exception $e) {
            return response()->json("Gagal", 400);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
