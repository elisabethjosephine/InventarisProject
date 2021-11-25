<?php

namespace App\Controllers;

use App\Models\SupplierModel;
use CodeIgniter\Session\Session;

class Supplier extends BaseController
{
    protected $supplierModel;

    public function __construct()
    {
        $this->supplierModel = new SupplierModel();
    }

    public function index()
    {

        $data = [
            'title' => 'Daftar Supplier',
            'supplier' => $this->supplierModel->getSupplier()
        ];
        return view('supplier/index', $data);
    }

    public function detail($id_supplier)
    {
        $data = [
            'title' => 'Detail Supplier',
            'supplier' => $this->supplierModel->getSupplier($id_supplier)
        ];

        return view('supplier/detail', $data);
    }

    public function tambah()
    {
        $data = [
            'title' => 'Tambah Data Supplier'
        ];
        return view('supplier/tambah', $data);
    }
    public function save()
    {

        // //ambil gambar
        // $fileGambar = $this->request->getFile('gambar');
        // //apakah tidak ada gambar yang diupload
        // if ($fileGambar->getError() == 4) {
        //     $namaGambar = 'default.png';
        // } else {
        //     //generate nama gambara random
        //     $namaGambar = $fileGambar->getRandomName();
        //     //pindahkan file ke folder img
        //     $fileGambar->move('img', $namaGambar);
        // }

        $newidSupplier = $this->supplierModel->getnewid();
        foreach ($newidSupplier as $newsupid)

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
            'id_supplier' => $newsupid,
            'nama_supplier' => $this->request->getVar('nama_supplier'),
            'alamat_supplier' => $this->request->getVar('alamat_supplier'),
            'telp_supplier' => $this->request->getVar('telp_supplier'),
            'gambar' => $namaGambar
        ];

        // dd($data);

        $this->supplierModel->insert($data);

        session()->setFlashdata('pesan', 'Data Berhasil Ditambahkan.');

        return redirect()->to('/supplier');
    }

    public function delete($id_supplier)
    {

        $this->supplierModel->delete($id_supplier);
        Session()->setFlashdata('pesan', 'data berhasil dihapus');
        return redirect()->to(base_url('/supplier'));
    }

    public function edit($id_supplier)
    {
        $data = [
            'title' => 'Ubah Data Supplier',
            'supplier' => $this->supplierModel->getSupplier($id_supplier)
        ];
        return view('supplier/edit', $data);
    }

    public function update($id_supplier)
    {
        $fileGambar = $this->request->getFile('gambar');

        //cek gambar, apakah etap gambar lama
        if ($fileGambar->getError() == 4) {
            $namaGambar = $this->request->getVar('gambarLama');
        } else {
            //genrate nama file random
            $namaGambar = $fileGambar->getRandomName();
            //pindahkan gambar
            $fileGambar->move('img', $namaGambar);
        }


        $data = [
            'id_supplier' => $id_supplier,
            'nama_supplier' => $this->request->getVar('nama_supplier'),
            'alamat_supplier' => $this->request->getVar('alamat_supplier'),
            'telp_supplier' => $this->request->getVar('telp_supplier'),
            'gambar' => $namaGambar

        ];
        // dd($data);


        $this->supplierModel->save($data);
        session()->setFlashdata('pesan', 'Data Berhasil Diubah.');

        return redirect()->to('/supplier');
    }
}
