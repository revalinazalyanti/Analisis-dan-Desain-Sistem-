-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 10 Sep 2024 pada 08.56
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpus`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `anggota`
--

CREATE TABLE `anggota` (
  `ID_Anggota` INT NOT NULL AUTO_INCREMENT,
  `Nama` VARCHAR(50) NOT NULL,
  `Alamat` TEXT NOT NULL,
  `Telepon` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(50),
  PRIMARY KEY (`ID_Anggota`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `anggota`
--

INSERT INTO `anggota` (`ID_Anggota`, `Nama`, `Alamat`, `Telepon`, `Email`) VALUES
(1, 'Agung', 'Bekasii', '089876543231', 'agung@example.com'),
(2, 'Iqbal', 'Karawang', '081234567890', 'iqbal@example.com'),
(3, 'Putri', 'Kranji', '083214431298', 'putri@example.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `ID_Buku` INT NOT NULL AUTO_INCREMENT,
  `Judul` VARCHAR(100) NOT NULL,
  `Pengarang` VARCHAR(50) NOT NULL,
  `Penerbit` VARCHAR(50),
  `Tahun_Terbit` YEAR,
  `Kategori` VARCHAR(30),
  `Jumlah_Copy` INT NOT NULL,
  PRIMARY KEY (`ID_Buku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`ID_Buku`, `Judul`, `Pengarang`, `Penerbit`, `Tahun_Terbit`, `Kategori`, `Jumlah_Copy`) VALUES
(1, 'Ayam Berkokok', 'Pak Tono', 'Penerbit A', 2001, 'Komik', 8),
(2, 'Aku dan Kamu', 'Hati Ini', 'Penerbit B', 2010, 'Novel', 37),
(3, 'Indonesiaku', 'Hartono', 'Penerbit C', 2020, 'Ensiklopedia', 20);

-- --------------------------------------------------------

--
-- Struktur dari tabel `peminjaman`
--

CREATE TABLE `peminjaman` (
  `ID_Peminjaman` INT NOT NULL AUTO_INCREMENT,
  `ID_Anggota` INT NOT NULL,
  `ID_Buku` INT NOT NULL,
  `Tanggal_Pinjam` DATE NOT NULL,
  `Tanggal_Jatuh_Tempo` DATE NOT NULL,
  PRIMARY KEY (`ID_Peminjaman`),
  FOREIGN KEY (`ID_Anggota`) REFERENCES `anggota`(`ID_Anggota`) ON DELETE CASCADE,
  FOREIGN KEY (`ID_Buku`) REFERENCES `buku`(`ID_Buku`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `peminjaman`
--

INSERT INTO `peminjaman` (`ID_Peminjaman`, `ID_Anggota`, `ID_Buku`, `Tanggal_Pinjam`, `Tanggal_Jatuh_Tempo`) VALUES
(1, 1, 1, '2020-04-20', '2020-05-20'),
(2, 3, 2, '2020-04-21', '2020-05-21'),
(3, 1, 2, '2020-05-04', '2020-06-04'),
(4, 2, 2, '2020-05-04', '2020-06-04'),
(5, 1, 1, '2020-06-04', '2020-07-04'),
(6, 1, 1, '2020-06-09', '2020-07-09'),
(7, 1, 1, '2020-06-04', '2020-07-04'),
(8, 1, 2, '2020-06-10', '2020-07-10');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengembalian`
--

CREATE TABLE `pengembalian` (
  `ID_Pengembalian` INT NOT NULL AUTO_INCREMENT,
  `ID_Peminjaman` INT NOT NULL,
  `Tanggal_Kembali` DATE NOT NULL,
  `Denda` DECIMAL(10,2),
  PRIMARY KEY (`ID_Pengembalian`),
  FOREIGN KEY (`ID_Peminjaman`) REFERENCES `peminjaman`(`ID_Peminjaman`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengembalian`
--

INSERT INTO `pengembalian` (`ID_Pengembalian`, `ID_Peminjaman`, `Tanggal_Kembali`, `Denda`) VALUES
(1, 1, '2020-04-21', NULL),
(2, 3, '2020-05-03', NULL),
(3, 3, '2020-05-03', NULL),
(4, 4, '2020-06-05', NULL),
(5, 5, '2020-06-11', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `ID_User` VARCHAR(20) NOT NULL,
  `Nama` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(50) NOT NULL,
  `Hak_Akses` ENUM('admin', 'anggota') NOT NULL,
  PRIMARY KEY (`ID_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`ID_User`, `Nama`, `Password`, `Hak_Akses`) VALUES
('admin', 'Marjo Marjono', 'admin', 'admin'),
('AG001', 'Agung', '123', 'anggota');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `anggota`
--
ALTER TABLE `anggota`
  ADD PRIMARY KEY (`ID_Anggota`);

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`ID_Buku`);

--
-- Indeks untuk tabel `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`ID_Peminjaman`);

--
-- Indeks untuk tabel `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD PRIMARY KEY (`ID_Pengembalian`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID_User`);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
