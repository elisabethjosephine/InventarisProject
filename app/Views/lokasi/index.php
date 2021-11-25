<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<div class="container">
    <div class="row">
        <div class="col">
            <h2 class="my-4">Daftar Lokasi</h2>
            <a href="/lokasi/tambah" class="btn btn-primary mb-4" style="float: right;">Tambah Supplier</a>
            <?php if (session()->getFlashdata('pesan')) : ?>
                <div class="alert alert-success" role="alert">
                    <?= session()->getFlashdata('pesan'); ?>
                </div>
            <?php endif; ?>
            <table class="table mt-2">
                <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Nama</th>
                        <th scope="col">Penanggung Jawab</th>
                        <th scope="col">Keterangan</th>
                        <th scope="col">Aksi</th>

                </thead>
                <tbody>
                    <?php $i = 1 ?>
                    <?php foreach ($lokasi as $lok) : ?>
                        <tr>
                            <th scope="row"><?= $i++; ?></th>
                            <td><?= $lok['nama_lokasi']; ?></td>
                            <td><?= $lok['penanggung_jawab']; ?></td>
                            <td><?= $lok['keterangan']; ?></td>
                            <td><a href="/lokasi/edit/<?= $lok['id_lokasi']; ?>" class="btn btn-warning">Update</a>
                                <form action="/lokasi/<?= $lok['id_lokasi']; ?>" method="post" class="d-inline">
                                    <?= csrf_field(); ?>
                                    <input type="hidden" name="_method" value="DELETE">
                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Apakah Anda Yakin ?');">Delete</button>
                                </form>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?= $this->endSection(); ?>