<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="/css/style.css">

<div class="wrap">
    <div class="header">
        <img src="img/logo.png" alt="our-logo" class="img-login">
    </div>
    <div class="container">
        <div class="row">
            <div class="col-4">
                <h2 align="center" class="title-login">Log in</h2>
                <?php if (session()->getFlashdata('pesan')) : ?>
                    <div class="alert alert-danger"><?= session()->getFlashdata('pesan') ?></div>
                <?php endif; ?>
                <form action="/login/auth" method="POST">
                    <div class="mb-3">
                        <label for="exampleInputEmail1" class="form-label">Username</label>
                        <input type="text" class="form-control" id="exampleInputEmail1" name="username" aria-describedby="emailHelp" placeholder="masukkan username">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label">Password</label>
                        <input type="password" class="form-control" id="exampleInputPassword1" name="password" placeholder="masukkan password">
                    </div>
                    <button type="submit" class="btn" id="btn-login">
                        <h3 class="login">Log in</h3>
                    </button>
                    <p align="center" class="copyright">Copyright © 2021 Inventool</p>
                </form>
            </div>
        </div>
    </div>
</div>
</div>