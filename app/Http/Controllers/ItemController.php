<?php

namespace App\Http\Controllers;

use App\Item;
use App\ItemCategory;
use Illuminate\Http\Request;
use PDF;

class ItemController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $barang = Item::orderBy('id', 'desc')->get();
        return view('barang.index', compact('barang'));
    }

    public function add()
    {
        $kategori = ItemCategory::all();
        return view('barang.add', compact('kategori'));
    }

    public function store(Request $request)
    {
        $barang = new Item;
        $barang->item_category_id = $request->item_category_id;
        $barang->name = $request->name;
        $barang->price = $request->price;
        $barang->stock = $request->stock;
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $name_image = 'image/' . time() . '_' . $image->getClientOriginalName();
            $image->move('image', $name_image);
            $barang->image = $name_image;
        }
        $barang->save();
        return redirect('/barang')->with('message', 'Berhasil tersimpan');
    }

    public function pdf()
    {
        return view('pdf');
    }
}
