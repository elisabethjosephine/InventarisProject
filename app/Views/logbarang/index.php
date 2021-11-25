<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<div class="container">
    <div class="row">
        <div class="col">
            <h2 class="my-4">Log Barang</h2 <table class="table mt-2">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Id Barang</th>
                        <th scope="col">Tanggal Masuk</th>
                        <th scope="col">Jumlah Masuk</th>
                        <th scope="col">Supplier</th>
                        <th scope="col">Keterangan</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $i = 1 ?>
                    <?php foreach ($log_barang as $l) : ?>
                        <tr>
                            <th scope="row"><?= $i++; ?></th>
                            <td><?= $l['id_barang']; ?></td>
                            <td><?= $l['tgl_masuk']; ?></td>
                            <td><?= $l['jml_masuk']; ?></td>
                            <td><?= $l['supplier']; ?></td>
                            <td><?= $l['keterangan']; ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?= $this->endSection(); ?>