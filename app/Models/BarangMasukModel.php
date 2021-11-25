<?php

namespace App\Models;

use App\Controllers\Supplier;
use CodeIgniter\Model;

class BarangMasukModel extends Model
{
    protected $DBGroup          = "default";
    protected $table            = "barang_masuk";
    protected $allowedFields    = ['id_barang', 'tgl_masuk', 'jml_masuk', 'supplier'];

    public function getBarangMasuk()
    {
        return $this->db->table('barang_masuk')
            ->join('barang', 'barang.id_barang=barang_masuk.id_barang')
            ->join('supplier', 'supplier.id_supplier=barang_masuk.supplier')
            ->get()->getResultArray();
    }

    // public function tambahBarangMasuk($id, $masuk, $supplier)
    // {
    //     $this->db->query("CALL tambahbarangmasuk('$id','$masuk', '$supplier')");
    // }

}
