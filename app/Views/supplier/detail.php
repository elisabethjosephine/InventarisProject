<?= $this->extend('layout/template'); ?>

<?= $this->section('content'); ?>
<div class="container">
  <div class="row">
    <div class="col">
      <h3 class="my-4"> Detail Supplier</h3>
      <a href="/supplier" class="btn btn-primary my-2">
        <img src="/img/Vector.png"> Kembali</a>
      <div class="cards">
        <img src="/img/<?= $supplier['gambar']; ?>" class="card-img-top">
        <div class="card-body">
          <h5 class="card-title"><?= $supplier['nama_supplier']; ?></h5>
          <p class="card-title"><?= $supplier['telp_supplier']; ?></p>
          <p class="card-text"><?= $supplier['alamat_supplier']; ?></p>

          <a href="/supplier/edit/<?= $supplier['id_supplier']; ?>" class="btn btn-warning">Update</a>
          <form action="/supplier/<?= $supplier['id_supplier']; ?>" method="post" class="d-inline">
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