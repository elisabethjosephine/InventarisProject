<?php

namespace App\Models;

use CodeIgniter\Model;

class SupplierModel extends Model
{
    protected $table = 'supplier';
    protected $primaryKey = "id_supplier";
    protected $allowedFields = ['id_supplier', 'nama_supplier', 'alamat_supplier', 'telp_supplier', 'gambar'];

    public function getSupplier($id_supplier = false)
    {
        if ($id_supplier == false) {
            return $this->db->table('supplier')->get()->getResultArray();
        }

        return $this->where(['id_supplier' => $id_supplier])->first();
    }
    public function getnewid()
    {
        $query = $this->db->query("SELECT newidsupplier()");
        $row = $query->getRow();

        return $row;
    }
}
