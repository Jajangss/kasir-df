@extends('layouts.app')

@section('content')
<div class="container">
    <form action="/barang/simpan" method="post" enctype="multipart/form-data">
        @csrf
        <div class="form-group">
            <label for="name">Nama Barang</label>
            <input type="text" name="name" id="name" class="form-control" placeholder="Masukan nama barang" required>
        </div>
        <div class="form-group">
            <label for="price">Harga</label>
            <input type="text" name="price" id="price" class="form-control" placeholder="Masukan harga" required>
        </div>
        <div class="form-group">
            <label for="stock">Stok</label>
            <input type="text" name="stock" id="stock" class="form-control" placeholder="Masukan stok" required>
        </div>
        <div class="form-group">
            <label for="item_category_id">Kategori</label>
            <select name="item_category_id" id="item_category_id" class="form-control">
                @foreach ($kategori as $item)
                <option value="{{ $item->id }}">{{ $item->name }}</option>
                @endforeach
            </select>
        </div>
        <div class="form-group">
            <label for="image">Gambar</label>
            <input type="file" name="image" id="image" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-primary">Simpan</button>
        <a href="/barang" class="btn btn-light">Kembali</a>
    </form>
</div>
@endsection