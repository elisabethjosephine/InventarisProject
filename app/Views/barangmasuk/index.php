<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<div class="container">
    <div class="row">
        <div class="col">
            <h2 class="my-4">Daftar Barang Masuk</h2>
            <a href="/barangmasuk/create" class="btn btn-primary mb-2" style="float: right;">Tambah Barang Masuk</a <table class="table mt-2">
            <?php if (session()->getFlashdata('pesan')) : ?>
                <div class="alert alert-success" role="alert">
                    <?= session()->getFlashdata('pesan'); ?>
                </div>
            <?php endif; ?>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Nama Barang</th>
                        <th scope="col">Nama Supplier</th>
                        <th scope="col">Tangal Masuk</th>
                        <th scope="col">Jumlah Masuk</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $i = 1 ?>
                    <?php foreach ($barang_masuk as $bm) : ?>
                        <tr>
                            <th scope="row"><?= $i++; ?></th>
                            <td><?= $bm['nama_barang']; ?></td>
                            <td><?= $bm['nama_supplier']; ?></td>
                            <td><?= $bm['tgl_masuk']; ?></td>
                            <td><?= $bm['jml_masuk']; ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?= $this->endSection(); ?>