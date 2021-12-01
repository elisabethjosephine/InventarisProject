-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 30 Nov 2021 pada 07.59
-- Versi server: 10.4.21-MariaDB
-- Versi PHP: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_inventaris_rplb_1920_08_elisabeth`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tambahbarangmasuk` (IN `kode` CHAR(8), IN `supplier` VARCHAR(8), IN `masuk` INT)  BEGIN
DECLARE jml_lama int DEFAULT 0;
DECLARE total_lama int DEFAULT 0;
DECLARE total_baru int DEFAULT 0;

START TRANSACTION;
IF masuk > 0 THEN
INSERT INTO barang_masuk(id_barang, tgl_masuk,jml_masuk,supplier) VALUES(kode,NOW(),masuk,supplier); 
SELECT jml_masuk INTO jml_lama FROM stok WHERE id_barang = kode;
SELECT total_barang INTO total_lama FROM stok WHERE id_barang = kode;
UPDATE stok SET jml_masuk =jml_lama+masuk WHERE id_barang = kode;
UPDATE stok SET total_barang = jml_masuk-jml_keluar WHERE id_barang = kode;
SELECT total_barang INTO total_baru FROM stok WHERE id_barang = kode;
UPDATE barang SET jumlah_barang = total_baru WHERE id_barang = kode;
COMMIT;
ELSE ROLLBACK;
END IF;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `newidbarang` () RETURNS CHAR(8) CHARSET utf8mb4 BEGIN
DECLARE id_lama CHAR(8) DEFAULT 'BRG00001';
DECLARE ambil_angka INT(5) DEFAULT 000;
DECLARE id_baru CHAR(8) DEFAULT 'BRG00000';
SELECT MAX(id_barang) INTO id_lama FROM barang;
SET ambil_angka = SUBSTR(id_lama, 4, 8);
SET ambil_angka = ambil_angka + 1;
SET id_baru = CONCAT('BRG', ambil_angka);
RETURN id_baru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `newidsupplier` () RETURNS VARCHAR(8) CHARSET utf8mb4 BEGIN
DECLARE id_lama VARCHAR(8) DEFAULT 'SPR001';
DECLARE ambil_angka INT(3) DEFAULT 000;
DECLARE id_baru VARCHAR(8) DEFAULT 'SPR000';
SELECT MAX(id_supplier) INTO id_lama FROM supplier;
SET ambil_angka = SUBSTR(id_lama, 4, 8);
SET ambil_angka = ambil_angka + 1;
SET id_baru = CONCAT('SPR', ambil_angka);
RETURN id_baru;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `id_barang` char(8) NOT NULL,
  `nama_barang` varchar(225) NOT NULL,
  `spesifikasi` text NOT NULL,
  `lokasi` char(4) NOT NULL,
  `kondisi` varchar(20) NOT NULL,
  `jumlah_barang` int(11) NOT NULL,
  `sumber_dana` char(4) NOT NULL,
  `gambar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `spesifikasi`, `lokasi`, `kondisi`, `jumlah_barang`, `sumber_dana`, `gambar`) VALUES
('BRG10001', 'Kursi Siswa', 'Bantalan Merah aluminium', 'R001', 'Baik', 56, 'S001', 'default.png'),
('BRG10002', 'Kursi Lipat Siswa', 'Kursi Lipat merk Informa Bantalan hitam', 'R002', 'Baik', 130, 'S001', 'default.png'),
('BRG20001', 'Laptop Acer Aspire E1 -471 ', 'Laptop Acer Aspire E1 -471 Core i3 RAM 4GB, HDD 500GB', 'R002', 'Baik', 62, 'S002', 'default.png'),
('BRG20002', 'Laptop Lenovo E550', 'Laptop Lenovo E550 intel Core i7, RAM 8GB HDD 1TB ', 'R002', 'Baik', 27, 'S004', 'default.png'),
('BRG20003', 'PC Rakitan i7 ', 'Intel Core i7 RAM 16GB SSD 512GB', 'R001', 'Baik', 43, 'S004', 'default.png'),
('BRG20004', 'Camera DSLR D60', 'DSLR Canon D60', 'R005', 'Baik', 47, 'S003', 'default.png'),
('BRG30001', 'Lighting set', 'stand light tronik 2 lighting tronik 2 100watt', 'R005', 'Baik', 2, 'S005', 'default.png'),
('BRG30002', 'Tripod Kamera', 'Takara Tripod', 'R005', 'Baik', 80, 'S002', 'default.png');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `barangmasuk`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `barangmasuk` (
`nama_barang` varchar(225)
,`nama_supplier` varchar(225)
,`tgl_masuk` date
,`jml_masuk` int(11)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `id_barang` char(8) NOT NULL,
  `tgl_keluar` date NOT NULL,
  `jml_keluar` int(11) NOT NULL,
  `supplier` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang_keluar`
--

INSERT INTO `barang_keluar` (`id_barang`, `tgl_keluar`, `jml_keluar`, `supplier`) VALUES
('BRG20001', '2017-11-06', 3, 'SPR005'),
('BRG10001', '2020-11-03', 16, 'SPR001');

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barang` char(8) NOT NULL,
  `tgl_masuk` date NOT NULL,
  `jml_masuk` int(11) NOT NULL,
  `supplier` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barang`, `tgl_masuk`, `jml_masuk`, `supplier`) VALUES
('BRG10001', '2007-08-03', 36, 'SPR001'),
('BRG10002', '2007-08-01', 36, 'SPR002'),
('BRG20001', '2013-07-09', 30, 'SPR004'),
('BRG20002', '2014-03-08', 23, 'SPR003'),
('BRG20003', '2020-11-10', 12, 'SPR004'),
('BRG20004', '2014-04-13', 16, 'SPR005'),
('BRG30001', '2018-04-06', 2, 'SPR005'),
('BRG30002', '2018-04-06', 4, 'SPR005'),
('BRG30002', '2021-11-19', 10, 'SPR005'),
('BRG30002', '2021-11-19', 6, 'SPR005'),
('BRG30002', '2021-11-19', 10, 'SPR005'),
('BRG30002', '2021-11-19', 10, 'SPR005'),
('BRG30002', '2021-11-19', 10, 'SPR005'),
('BRG30001', '2021-11-20', 10, 'SPR005'),
('BRG30001', '2021-11-20', 10, 'SPR005'),
('BRG30002', '2021-11-19', 5, 'SPR005'),
('BRG30002', '2021-11-19', 10, 'SPR005'),
('BRG10002', '2021-11-19', 10, 'SPR002'),
('BRG20001', '2021-11-19', 10, 'SPR001'),
('BRG20003', '2021-11-19', 10, 'SPR002'),
('BRG10001', '2021-11-19', 10, 'SPR001'),
('BRG20004', '2021-11-19', 2, 'SPR001'),
('BRG20001', '2021-11-19', 10, 'SPR002'),
('BRG20003', '2021-11-19', 11, 'SPR005'),
('BRG20004', '2021-11-19', 20, 'SPR004'),
('BRG20001', '2021-11-19', 5, 'SPR004'),
('BRG20004', '2021-11-19', 9, 'SPR008'),
('BRG20002', '2021-11-19', 4, 'SPR009'),
('BRG10002', '2021-11-30', 90, 'SPR011');

--
-- Trigger `barang_masuk`
--
DELIMITER $$
CREATE TRIGGER `logbarang` AFTER INSERT ON `barang_masuk` FOR EACH ROW BEGIN
INSERT INTO log_barang(id_barang,tgl_masuk,jml_masuk,supplier,keterangan) VALUES (New.id_barang, New.tgl_masuk, New.jml_masuk, New.supplier, "Barang Berhasil ditambahkan");
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `jumlah_barang_dipinjam_tiap_ruang`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `jumlah_barang_dipinjam_tiap_ruang` (
`id_lokasi` char(4)
,`nama_lokasi` varchar(225)
,`jml_barang` bigint(21)
,`dipinjam` bigint(21)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `level_user`
--

CREATE TABLE `level_user` (
  `id_level` char(3) NOT NULL,
  `nama` varchar(225) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `level_user`
--

INSERT INTO `level_user` (`id_level`, `nama`, `keterangan`) VALUES
('U01', 'Administrator', ''),
('U02', 'Manajemen', ''),
('U03', 'Peminjam', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_barang`
--

CREATE TABLE `log_barang` (
  `id_barang` char(8) NOT NULL,
  `tgl_masuk` date NOT NULL,
  `jml_masuk` int(11) NOT NULL,
  `supplier` char(8) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `log_barang`
--

INSERT INTO `log_barang` (`id_barang`, `tgl_masuk`, `jml_masuk`, `supplier`, `keterangan`) VALUES
('BRG20004', '2021-11-19', 2, 'SPR001', 'Barang Berhasil ditambahkan'),
('BRG20001', '2021-11-19', 10, 'SPR002', 'Barang Berhasil ditambahkan'),
('BRG20003', '2021-11-19', 11, 'SPR005', 'Barang Berhasil ditambahkan'),
('BRG20004', '2021-11-19', 20, 'SPR004', 'Barang Berhasil ditambahkan'),
('BRG20001', '2021-11-19', 5, 'SPR004', 'Barang Berhasil ditambahkan'),
('BRG20004', '2021-11-19', 9, 'SPR008', 'Barang Berhasil ditambahkan'),
('BRG20002', '2021-11-19', 4, 'SPR9', 'Barang Berhasil ditambahkan'),
('BRG10002', '2021-11-30', 90, 'SPR011', 'Barang Berhasil ditambahkan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lokasi`
--

CREATE TABLE `lokasi` (
  `id_lokasi` char(4) NOT NULL,
  `nama_lokasi` varchar(225) NOT NULL,
  `penanggung_jawab` varchar(225) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `lokasi`
--

INSERT INTO `lokasi` (`id_lokasi`, `nama_lokasi`, `penanggung_jawab`, `keterangan`) VALUES
('R001', 'Lab RPL 1', 'Satria Ade Putra', 'Lantai 3'),
('R002', 'Lab RPL 2', 'Satria Ade Putra', 'Lantai 3'),
('R003', 'Lab TKJ 1', 'Supriyadi', 'Lantai 2 Gedung D'),
('R004', 'Lab TKJ 2', 'Supriyadi', 'Lantai 2 Gedung D'),
('R005', 'Lab Multimedia', 'Bayu Setiawan', 'Gedung Multimedia');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pinjam_barang`
--

CREATE TABLE `pinjam_barang` (
  `id_pinjam` int(11) NOT NULL,
  `peminjam` char(8) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `barang_pinjam` char(8) NOT NULL,
  `jml_pinjam` int(11) NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kondisi` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pinjam_barang`
--

INSERT INTO `pinjam_barang` (`id_pinjam`, `peminjam`, `tgl_pinjam`, `barang_pinjam`, `jml_pinjam`, `tgl_kembali`, `kondisi`) VALUES
(1, 'USR20001', '2021-06-09', 'BRG20002', 1, '2021-06-23', 'Baik'),
(2, 'USR20002', '2021-06-09', 'BRG20002', 1, '2021-08-21', 'Baik'),
(3, 'USR20004', '2021-08-05', 'BRG20004', 3, '2021-08-21', 'Baik'),
(4, 'USR20004', '2021-08-05', 'BRG30002', 3, '2021-08-05', 'Baik');

-- --------------------------------------------------------

--
-- Struktur dari tabel `stok`
--

CREATE TABLE `stok` (
  `id_barang` char(8) NOT NULL,
  `jml_masuk` int(11) NOT NULL,
  `jml_keluar` int(11) NOT NULL,
  `total_barang` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `stok`
--

INSERT INTO `stok` (`id_barang`, `jml_masuk`, `jml_keluar`, `total_barang`) VALUES
('BRG10001', 56, 0, 56),
('BRG10002', 146, 16, 130),
('BRG20001', 65, 3, 62),
('BRG20002', 27, 0, 27),
('BRG20003', 43, 0, 43),
('BRG20004', 47, 0, 47),
('BRG30001', 22, 0, 2),
('BRG30002', 80, 0, 80);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sumber_dana`
--

CREATE TABLE `sumber_dana` (
  `id_sumber` char(4) NOT NULL,
  `nama_sumber` varchar(225) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `sumber_dana`
--

INSERT INTO `sumber_dana` (`id_sumber`, `nama_sumber`, `keterangan`) VALUES
('S001', 'Komite 07/09', 'Bantuan Komite 2007/2009'),
('S002', 'Komite 13', 'Bantuan Komite 2013'),
('S003', 'sed t-vet', 'Bantuan Kerja sama Indonesia Jerman'),
('S004', 'BOPD 2020', 'Bantuan Provinsi Jawa Barat 2020'),
('S005', 'BOSDA 2018', 'Bantuan Operasional Sekolah Daerah Jawa Barat 2018');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` varchar(8) NOT NULL,
  `nama_supplier` varchar(225) NOT NULL,
  `alamat_supplier` text NOT NULL,
  `telp_supplier` varchar(14) NOT NULL,
  `gambar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama_supplier`, `alamat_supplier`, `telp_supplier`, `gambar`) VALUES
('SPR001', 'INFORMA-MALL METROPOLITAN BEKASI', 'Mal Metropolitan, Jl. KH. Noer Ali No.1, RT.008/RW.002, Pekayon Jaya, Kec. Bekasi Sel., Kota Bks, Jawa Barat 17148', ' 0812-9604-605', 'default.png'),
('SPR002', 'Mitrakantor.com', 'Jl. I Gusti Ngurah Rai No.20, RT.1/RW.10, Klender, Kec. Duren Sawit, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13470', '02122862086', 'default.png'),
('SPR003', 'bhinneka.com', 'Jl. Gn. Sahari No.73C, RT.9/RW.7, Gn. Sahari Sel., Kec. Kemayoran, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10610', '02129292828', 'bhinneka.png'),
('SPR004', 'World Computer', 'Harco Mangga Dua Plaza, Jalan Arteri Jl. Mangga Dua Raya No.17, RW.11, Mangga Dua Sel., Kecamatan Sawah Besar, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10730', '0216125266', 'default.png'),
('SPR005', 'Anekafoto Metro Atom', 'Metro Atom Plaza Jalan Samanhudi Blok AKS No. 19, RT.20/RW.3, Ps. Baru, Kecamatan Sawah Besar, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10710', '0213455544', 'default.png'),
('SPR008', 'Joko Furniture', 'Jalan Kebagusan no.80', '43552443253', ''),
('SPR009', 'IKEA Alam Sutera', 'Jalan Kepompong Ulat Sutera No.90', '089652504169', '1637293134_46cb49c6210db0d3f9c9.png'),
('SPR010', 'Toko Sumber Bagus', 'Jl. Mentimun III No.09', '089652515022', '1637411918_152dffad6fe5d51e52d0.png'),
('SPR011', 'Toko Makmur Raya', 'Jl. Kedondong Raya No.10 ', '0877 778 887', '1637411993_06d4d46504b1e8036269.png');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` char(8) NOT NULL,
  `nama` varchar(225) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `level` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama`, `username`, `password`, `level`) VALUES
('USR00001', 'Nana Sukmana', 'admin', '$2y$10$85Jviwu2/xyekR2M.FgX9.jAKPYtXymk6dbc4zwJVWUdnQYdoOXO2', 'U01'),
('USR00002', 'Deden Deendi', 'toolman=RPL', '1c494150c9ed934fff9dd4c4dc7526e8\r\n', 'U02'),
('USR00003', 'Ilham Kamil', 'toolman=MM', '6510816b668a88c6dfabe403fb5d4a8a\r\n', 'U02'),
('USR00004', 'Abdul Rahman', 'toolman=TKJ', '77a5f557dff174606b79cebeb89268e9\r\n', 'U02'),
('USR20001', 'Dzaki', 'dzaki', 'ebae2ccc3fe07662bb337a96c883954f\r\n', 'U03'),
('USR20002', 'Sulthan', 'Sultan', '9af82031d374b97c9e73132a413cbdf5\r\n', 'U03'),
('USR20003', 'Fahru', 'fahru', '5f390ada8b91e727c8c12536bbe9a854\r\n', 'U03'),
('USR20004', 'Akwan', 'akwan', '2d1257528a0cea42d6d9178b3a90d30f\r\n', 'U03');

-- --------------------------------------------------------

--
-- Struktur untuk view `barangmasuk`
--
DROP TABLE IF EXISTS `barangmasuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `barangmasuk`  AS SELECT `barang`.`nama_barang` AS `nama_barang`, `supplier`.`nama_supplier` AS `nama_supplier`, `barang_masuk`.`tgl_masuk` AS `tgl_masuk`, `barang_masuk`.`jml_masuk` AS `jml_masuk` FROM ((`barang_masuk` join `barang` on(`barang`.`id_barang` = `barang_masuk`.`id_barang`)) join `supplier` on(`supplier`.`id_supplier` = `barang_masuk`.`supplier`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `jumlah_barang_dipinjam_tiap_ruang`
--
DROP TABLE IF EXISTS `jumlah_barang_dipinjam_tiap_ruang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jumlah_barang_dipinjam_tiap_ruang`  AS SELECT `lokasi`.`id_lokasi` AS `id_lokasi`, `lokasi`.`nama_lokasi` AS `nama_lokasi`, count(`barang`.`nama_barang`) AS `jml_barang`, count(`pinjam_barang`.`barang_pinjam`) AS `dipinjam` FROM ((`lokasi` join `barang` on(`lokasi`.`id_lokasi` = `barang`.`lokasi`)) join `pinjam_barang` on(`barang`.`id_barang` = `pinjam_barang`.`barang_pinjam`)) GROUP BY `lokasi`.`nama_lokasi` HAVING count(`pinjam_barang`.`barang_pinjam`) > 1 ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `sumber_dana` (`sumber_dana`),
  ADD KEY `lokasi` (`lokasi`);

--
-- Indeks untuk tabel `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `supplier` (`supplier`);

--
-- Indeks untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `supplier` (`supplier`),
  ADD KEY `id_supplier` (`supplier`),
  ADD KEY `supplier_2` (`supplier`);

--
-- Indeks untuk tabel `level_user`
--
ALTER TABLE `level_user`
  ADD PRIMARY KEY (`id_level`);

--
-- Indeks untuk tabel `log_barang`
--
ALTER TABLE `log_barang`
  ADD KEY `id_barang` (`id_barang`);

--
-- Indeks untuk tabel `lokasi`
--
ALTER TABLE `lokasi`
  ADD PRIMARY KEY (`id_lokasi`);

--
-- Indeks untuk tabel `pinjam_barang`
--
ALTER TABLE `pinjam_barang`
  ADD PRIMARY KEY (`id_pinjam`),
  ADD KEY `barang_pinjam` (`barang_pinjam`),
  ADD KEY `peminjam` (`peminjam`);

--
-- Indeks untuk tabel `stok`
--
ALTER TABLE `stok`
  ADD KEY `id_barang` (`id_barang`);

--
-- Indeks untuk tabel `sumber_dana`
--
ALTER TABLE `sumber_dana`
  ADD PRIMARY KEY (`id_sumber`);

--
-- Indeks untuk tabel `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `level` (`level`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`lokasi`) REFERENCES `lokasi` (`id_lokasi`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `stok` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_ibfk_3` FOREIGN KEY (`sumber_dana`) REFERENCES `sumber_dana` (`id_sumber`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD CONSTRAINT `barang_keluar_ibfk_1` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`id_supplier`),
  ADD CONSTRAINT `barang_keluar_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`);

--
-- Ketidakleluasaan untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD CONSTRAINT `barang_masuk_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_masuk_ibfk_2` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`id_supplier`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pinjam_barang`
--
ALTER TABLE `pinjam_barang`
  ADD CONSTRAINT `pinjam_barang_ibfk_1` FOREIGN KEY (`peminjam`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `pinjam_barang_ibfk_2` FOREIGN KEY (`barang_pinjam`) REFERENCES `barang` (`id_barang`);

--
-- Ketidakleluasaan untuk tabel `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`level`) REFERENCES `level_user` (`id_level`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
