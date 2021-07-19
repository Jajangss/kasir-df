@extends('layouts.app')

@section('content')
<div class="container">
    @if (session('message'))
    <div class="row">
        <div class="col-md-12">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                {{ session('message') }}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </div>
    </div>
    @endif
    <div class="d-flex justify-content-between">
        <h3>Data Barang</h3>
        <a href="/barang/tambah" class="btn btn-primary mb-3">Tambah Barang</a>
    </div>
    <table class="table table-striped table-bordered">
        <thead class="thead-dark">
            <tr>
                <th scope="col">#</th>
                <th scope="col">Nama</th>
                <th scope="col">Harga</th>
                <th scope="col">Stok</th>
                <th scope="col">Kategori</th>
                <th scope="col">Gambar</th>
            </tr>
        </thead>
        <tbody>
            @php
            $no = 1;
            @endphp
            @foreach ($barang as $item)
            <tr>
                <td>{{ $no++ }}</td>
                <td>{{ $item->name }}</td>
                <td>{{ $item->price }}</td>
                <td>{{ $item->stock }}</td>
                <td>{{ $item->category->name }}</td>
                <td>
                    <a href="{{ asset($item->image) }}" target="_blank">
                        <img src="{{ asset($item->image) }}" width="100">
                    </a>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection