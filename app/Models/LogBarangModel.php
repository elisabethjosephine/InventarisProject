<?php

namespace App\Models;

use CodeIgniter\Model;

class LogBarangModel extends Model
{
    protected $DBGroup          = 'default';
    protected $table            = 'log_barang';
    protected $allowedFields    = ['id_barang', 'tgl_masuk', 'jml_masuk', 'supplier', 'keterangan'];

    public function getlogbarang()
    {
        return $this->db->table('log_barang')->get()->getResultArray();
    }
}
