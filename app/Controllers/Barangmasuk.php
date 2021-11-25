<?php

namespace App\Controllers;

use App\Models\BarangMasukModel;
use App\Models\BarangModel;
use App\Models\SupplierModel;

class Barangmasuk extends BaseController
{
    protected $barangMasukModel;
    protected $supplier;
    protected $barang;

    public function __construct()
    {
        $this->barangMasukModel = new BarangMasukModel();
        $this->barang = new BarangModel();
        $this->supplier = new SupplierModel();
    }

    public function index()
    {

        $data = [
            'title' => 'Daftar Barang Masuk',
            'barang_masuk' => $this->barangMasukModel->getBarangMasuk()
        ];

        return view('BarangMasuk/index', $data);
    }
    public function create()
    {
        $data = [
            'title' => 'Tambah Barang Masuk',
            'barang_masuk' => $this->barangMasukModel->getBarangMasuk(),
            'barang' => $this->barang->getbarang(),
            'supplier' => $this->supplier->getSupplier()

        ];

        // dd($data);

        return view('BarangMasuk/create', $data);
    }

    public function save()
    {

        $id_barang = $this->request->getVar('id_barang');
        // $tgl_masuk = $this->request->getVar('tgl_masuk');
        $jml_masuk = intval($this->request->getVar('jml_masuk'));
        $supplier = $this->request->getVar('supplier');


        // dd($id_barang, $jml_masuk, $supplier);

        $this->barangMasukModel->query("CALL tambahbarangmasuk('" . $id_barang . "','" . $supplier . "','" . $jml_masuk . "');");

        session()->setFlashdata('pesan', 'Data Berhasil Ditambahkan.');

        return redirect()->to(base_url('/barangmasuk'));
    }
}
