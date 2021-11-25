<?= $this->extend('layout/template'); ?>


<?= $this->section('content'); ?>
<div class="container">
    <div class="row">
        <div class="col-8">
            <h2 class="my-4">Form Tambah Data Supplier</h2>
            <form action="/supplier/save" method="POST" enctype="multipart/form-data">
                <?= csrf_field(); ?>
                <div class="mb-3">
                    <label for="nama_supplier" class="form-label">Nama</label>
                    <input type="text" class="form-control" id="nama_supplier" name="nama_supplier" autofocus required>
                </div>
                <div class="mb-3">
                    <label for="alamat_supplier" class="form-label">Alamat</label>
                    <input type="text" class="form-control" name="alamat_supplier" id="alamat_supplier" required>
                </div>
                <div class="mb-3">
                    <label for="telp_supplier" class="form-label">Telepon</label>
                    <input type="text" class="form-control" name="telp_supplier" id="telp_supplier" required>
                </div>
                <div class="mb-3">
                    <label for="gambar" class="form-label">Gambar</label>
                    <input class="form-control" type="file" id="gambar" name="gambar">
                </div>
                <button type="submit" class="btn btn-primary">Tambah Data</button>
            </form>

        </div>
    </div>
</div>
<?= $this->endSection(); ?>