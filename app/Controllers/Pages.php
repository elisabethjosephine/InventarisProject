<?php

namespace App\Controllers;

class Pages extends BaseController
{
    public function Home()
    {
        $data = [
            'title' => 'Home | Inventool'
        ];

        return view('pages/home', $data);
    }
}
