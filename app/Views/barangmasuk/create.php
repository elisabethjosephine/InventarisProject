<?= $this->extend('layout/template'); ?>


<?= $this->section('content'); ?>
<div class="container">
    <div class="row">
        <div class="col-8">
            <h2 class="my-4">Form Tambah Data Barang Masuk</h2>
            <form action="/Barangmasuk/save" method="POST" class="barangmasuk" enctype="multipart/form-data">
                <?= csrf_field(); ?>
                <label for="id_supplier" class="form-label">Id Barang</label>
                <select class="form-select" aria-label="Default select example" name="id_barang">
                    <?php foreach ($barang as $b) : ?>
                        <option value="<?= $b['id_barang']; ?>"><?= $b['nama_barang']; ?></option>
                    <?php endforeach; ?>
                </select>
                <div class="mb-3">
                    <label for="jml_masuk" class="form-label">Jumlah Masuk</label>
                    <input type="text" class="form-control" id="jml_masuk" name="jml_masuk">
                </div>
                <div class="mb-3">
                    <label for="id_supplier" class="form-label">Id Supplier</label>
                    <select class="form-select" aria-label="Default select example" name="supplier">
                        <?php foreach ($supplier as $s) : ?>
                            <option value="<?= $s['id_supplier']; ?>"><?= $s['nama_supplier']; ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Tambah Data</button>
            </form>

        </div>
    </div>
</div>
<?= $this->endSection(); ?>