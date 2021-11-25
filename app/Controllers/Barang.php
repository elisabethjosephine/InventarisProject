<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\BarangModel;

class Barang extends BaseController
{
    protected $barang;

    public function __construct()
    {
        $this->barang = new BarangModel();
    }

    public function index()
    {
        $data = [
            'title' => 'Daftar Barang',
            'barang' => $this->barang->getbarang()
        ];
        return view('barang/index', $data);
    }

    public function detail($id_barang)
    {
        $data = [
            'title' => 'Detail Barang',
            'barang' => $this->barang->getbarang($id_barang)
        ];

        return view('barang/detail', $data);
    }

    public function tambah()
    {
        $data = [
            'title' => 'Tambah Data Barang'
        ];
        return view('barang/tambah', $data);
    }

    public function save()
    {
        $newidBarang = $this->barang->getnewid();
        foreach ($newidBarang as $newbarid)

            $fileGambar = $this->request->getFile('gambar');
        //apakah tidak ada gambar yang diupload
        if ($fileGambar->getError() == 4) {
            $namaGambar = 'photo.png';
        } else {
            //generate nama gambara random
            $namaGambar = $fileGambar->getRandomName();
            //pindahkan file ke folder img
            $fileGambar->move('img', $namaGambar);
        }

        $data = [
            'id_barang' => $newbarid,
            'nama_barang' => $this->request->getVar('nama_barang'),
            'spesifikasi' => $this->request->getVar('spesifikasi'),
            'lokasi' => $this->request->getVar('lokasi'),
            'kondisi' => $this->request->getVar('kondisi'),
            'jumlah_barang' => intval($this->request->getVar('jumlash_barang')),
            'sumber_dana' => $this->request->getVar('sumber_dana'),
            'gambar' => $namaGambar
        ];

        // dd($data);
        $this->barang->insert($data);
        session()->setFlashdata('pesan', 'Data Berhasil Ditambahkan.');
        return redirect()->to('/barang');
    }
}
