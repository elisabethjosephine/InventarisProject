<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<div class="container">
    <div class="row">
        <div class="col">
            <h3 class="my-4"> Detail Barang</h3>
            <a href="/barang" class="btn btn-primary my-2">
                <img src="/img/Vector.png"> Kembali</a>
            <div class="cards">
                <img src="/img/<?= $barang['gambar']; ?>" class="card-img-top">
                <div class="card-body">
                    <h5 class="card-title"><?= $barang['nama_barang']; ?></h5>
                    <p class="card-title"><?= $barang['lokasi']; ?></p>
                    <p class="card-text"><?= $barang['kondisi']; ?></p>
                    <p class="card-text"><?= $barang['jumlah_barang']; ?></p>
                    <p class="card-text"><?= $barang['spesifikasi']; ?></p>

                    <a href="/barang/edit/<?= $barang['id_barang']; ?>" class="btn btn-warning">Update</a>
                    <form action="/barang/<?= $barang['id_barang']; ?>" method="post" class="d-inline">
                        <?= csrf_field(); ?>
                        <input type="hidden" name="_method" value="DELETE">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Apakah Anda Yakin ?');">Delete</button>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>
<?= $this->endSection(); ?>