<?php

namespace App\Models;

use CodeIgniter\Model;

class BarangModel extends Model
{
    protected $DBGroup          = 'default';
    protected $table            = 'barang';
    protected $primaryKey       = 'id';
    protected $useAutoIncrement = true;
    protected $insertID         = 0;
    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;
    protected $protectFields    = true;
    protected $allowedFields    = [
        'id_barang', 'nama_barang', 'spesifikasi', 'lokasi', 'kondisi', 'jumlah_barang', 'sumber_dana', 'gambar'
    ];

    public function getbarang($id_barang = false)
    {
        if ($id_barang == false) {
            return $this->db->table('barang')->get()->getResultArray();
        }

        return $this->where(['id_barang' => $id_barang])->first();
    }
    public function getnewid()
    {
        $query = $this->db->query("SELECT newidbarang()");
        $row = $query->getRow();

        return $row;
    }
}
