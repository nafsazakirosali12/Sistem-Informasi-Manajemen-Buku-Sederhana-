-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 28 Nov 2025 pada 20.36
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simbs`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku`
--

CREATE TABLE `buku` (
  `id_buku` int(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `judul` varchar(200) NOT NULL,
  `deskripsi_buku` text DEFAULT NULL,
  `penulis` varchar(100) DEFAULT NULL,
  `gambar` varchar(100) DEFAULT NULL,
  `tahun_terbit` int(11) DEFAULT NULL,
  `tanggal_input` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `aksi` varchar(50) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `buku`
--

INSERT INTO `buku` (`id_buku`, `id_kategori`, `judul`, `deskripsi_buku`, `penulis`, `gambar`, `tahun_terbit`, `tanggal_input`, `aksi`) VALUES
(1, 1, 'Hujan', 'Novel inspiratif tentang kehidupan dan perjuangan.', 'Tere Liye', '1.jpg', 2022, '2025-11-28 13:29:16', ''),
(2, 3, 'Bumi', 'Novel petualangan fantasi yang populer.', 'Tere Liye', '2.jpg', 2022, '2025-11-28 18:58:42', ''),
(3, 1, 'Rindu', 'Cerita tentang romansa dan persahabatan.', 'Tere Liye', 'Rindu.jpg', 2023, '2025-11-28 13:31:04', ''),
(4, 1, 'Ayah', 'Novel tentang kasih sayang dan keluarga', 'Andrea Hirata', '4.jpg', 2023, '2025-11-28 13:28:43', ''),
(5, 1, 'Laskar Pelangi 2', 'Sekuel kisah inspiratif Laskar Pelangi.', 'Andrea Hirata', 'Laskar Pelangi 2.jpg', 2023, '2025-11-28 13:32:08', ''),
(6, 3, 'Selamat Tinggal', 'Novel refleksi tentang kehidupan dan perpisahan.', 'Tere Liye', '6.jpg', 2023, '2025-11-28 18:58:42', ''),
(7, 3, 'Perahu Kertas 2', 'Sekuel cerita romantis dan perjalanan yang panjang.', 'Dee Lestari', '7.jpg', 2023, '2025-11-28 18:58:42', ''),
(8, 1, 'Dilan 1991', 'Novel remaja populer lanjutan Dilan 1990.', 'Pidi Baiq', '8.jpg', 2022, '2025-11-28 18:58:42', ''),
(9, 3, 'Supernova: Partikel', 'Novel fiksi ilmiah dan spiritual.', 'Dewi Lestari', '9.jpg', 2022, '2025-11-28 18:58:42', ''),
(10, 2, 'Al-Quran', 'Kitab suci umat Islam.', '-', '10.jpg', 2022, '2025-11-28 18:58:42', ''),
(11, 4, 'Fisika Dasar', 'Buku pengantar fisika dasar untuk mahasiswa.', 'Budi Santoso', '11.png', 2022, '2025-11-28 18:58:42', ''),
(12, 1, 'Bulan', 'Novel tentang persahabatan dan perjuangan hidup.', 'Tere Liye', '12.jpg', 2025, '2025-11-28 18:58:42', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(100) NOT NULL,
  `tanggal_input` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `aksi` varchar(50) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`, `tanggal_input`, `aksi`) VALUES
(1, 'Fiksi', '2025-11-28 11:22:55', ''),
(2, 'Kitab Suci ', '2025-11-28 11:23:09', ''),
(3, 'Non-Fiksi', '2025-11-28 11:24:03', ''),
(4, 'Pendidikan', '2025-11-26 17:00:00', ''),
(6, 'Sejarah Indonesiaa', '2025-11-28 13:01:42', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `username`, `email`, `password`) VALUES
(1, 'oca12', 'oca12@gmail.com', '$2y$10$4WxmyTLBHhqwu4z9FzESN.wlle4tXgBhWgG6jqMf7UsBDAtDs1bHK'),
(2, 'nafsa ', 'nafsa@gmail.com', '$2y$10$Fwtd4ZsvaUGzYMaCGWNhW.1uUaC236giBkCChyHHLwcvCDWr6iMiu'),
(3, 'nafsa zaki rosali', 'nafsazakirosali@gmail.com', '$2y$10$I0KbB3R/0Cpia9UIgwzCKuFia.nzi4WlIJnlG3wl7Uqw9gPT2n9WK'),
(4, 'nafsazr', 'nafsazr@gmail.com', '$2y$10$31M7pUmNhtmCsI2UnSrEgu2Faflkn3Kchq1vWx.J1X836utwCIaeu');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`),
  ADD KEY `fk_kategori` (`id_kategori`);

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `buku`
--
ALTER TABLE `buku`
  ADD CONSTRAINT `fk_kategori` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
