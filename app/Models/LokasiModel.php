<?php

namespace App\Models;

use CodeIgniter\Model;

class LokasiModel extends Model
{

    protected $table            = 'lokasi';
    protected $primaryKey       = 'id_lokasi';
    protected $allowedFields    = ['id_lokasi', 'nama_lokasi', 'penanggung_jawab', 'keterangan'];

    public function getLokasi($id_lokasi = false)
    {
        if ($id_lokasi == false) {
            return $this->db->table('lokasi')->get()->getResultArray();
        }

        return $this->where(['id_lokasi' => $id_lokasi])->first();
    }
}
