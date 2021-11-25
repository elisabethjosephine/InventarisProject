<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\UserModel;

class Login extends BaseController
{
    protected $usermodel;

    public function __construct()
    {
        $this->usermodel = new UserModel();
    }

    public function index()
    {
        $data = [
            'title' => 'Login',
        ];

        // helper(['form']);
        return view('login/login', $data);
    }

    public function auth()
    {
        //ambil value dari form login 
        $username = $this->request->getVar('username');
        $password = $this->request->getVar('password');

        //cari user
        $data = $this->usermodel->where('username', $username)
            ->first();

        //validasi user
        if ($data) {
            //ambil data password user
            $verify_pass = password_verify($password,  $data['password']);

            //validasi password  
            if ($verify_pass) {
                //buat session jika password benar
                $session_user = [
                    'id_user' => $data['id_user'],
                    'nama' => $data['nama'],
                    'username' => $data['username'],
                    'logged_in' => true
                ];

                session()->set($session_user);
                return redirect()->to('/supplier');
            } else {
                session()->setFlashdata('pesan', 'Password Anda Salah');
                return redirect()->to(base_url() . '/login');
            }
        } else {
            session()->setFlashdata('pesan', 'Username Anda Salah');
            return redirect()->to(base_url() . '/login');
        }
    }

    public function logout()
    {
        $session = session();
        $session->destroy();
        return redirect()->to(base_url() . '/login');
    }
}
