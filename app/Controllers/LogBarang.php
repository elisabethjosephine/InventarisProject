<?php

namespace App\Controllers;

use App\Models\LogBarangModel;

class LogBarang extends BaseController
{

    protected $logbarang;

    public function __construct()
    {
        $this->logbarang = new LogBarangModel();
    }
    public function index()
    {
        $data = [
            'title' => 'Log Barang',
            'log_barang' => $this->logbarang->getlogbarang()
        ];

        return view('logbarang/index', $data);
    }
}
