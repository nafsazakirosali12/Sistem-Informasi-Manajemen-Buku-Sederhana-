<?php
// koneksi ke database
// var conn = fungsi koneksi("nama_host", "username", "password", "nama_db"); 
// cara cek username di db mysql dengan CMD --> select user();
$conn = mysqli_connect("localhost", "root", "", "simbs");

// fungsi untuk menampilkan data dari database
function query($query){
    global $conn;

	$result = mysqli_query($conn, $query);
	$rows = [];
	while( $row = mysqli_fetch_assoc($result) ) {
		$rows[] = $row;
	}
	return $rows;
}

// Fungsi search kategori 
function search_kategori($keyword){
    $query = "SELECT * FROM kategori
        WHERE 
		nama_kategori LIKE '%$keyword%'
    ";
    return query($query);
}

// fungsi untuk mencari data buku
function search_buku($keyword){
    global $conn;

    $query = "
        SELECT 
            buku.*, 
            kategori.nama_kategori
        FROM buku
        LEFT JOIN kategori 
            ON buku.id_kategori = kategori.id_kategori
        WHERE
            buku.id_buku LIKE '%$keyword%' OR
            buku.judul LIKE '%$keyword%' OR
            buku.deskripsi_buku LIKE '%$keyword%' OR
            buku.penulis LIKE '%$keyword%' OR
            buku.gambar LIKE '%$keyword%' OR
            buku.tahun_terbit LIKE '%$keyword%' OR
            kategori.nama_kategori LIKE '%$keyword%'
    ";

    return query($query);
}


// fungsi untuk menambahkan data buku
function tambah_buku($data){
    global $conn;

    $judul          = htmlspecialchars($data['judul']);
    $id_kategori    = $data['id_kategori'];
    $deskripsi_buku = htmlspecialchars($data['deskripsi_buku']);
    $penulis        = htmlspecialchars($data['penulis']);
    $tahun_terbit   = $data['tahun_terbit'];

    
    $gambar = upload_gambar($judul);
    if (!$gambar) {
        return false; 
    }
    
    $query = "INSERT INTO buku 
                (judul, id_kategori, deskripsi_buku, penulis, gambar, tahun_terbit) 
              VALUES 
                ('$judul', '$id_kategori', '$deskripsi_buku', '$penulis', '$gambar', '$tahun_terbit')";

    mysqli_query($conn, $query);

    return mysqli_affected_rows($conn);
}


// fungsi untuk menghapus data buku 
function hapus_buku($id){
    global $conn;

    $query = "DELETE FROM buku WHERE id_buku = $id";

    $result = mysqli_query($conn, $query);

    return mysqli_affected_rows($conn);    
}

// fungsi untuk mengubah data buku
function ubah_buku($data){
    global $conn;

    $id_buku        = $data['id_buku'];
    $judul          = $data['judul'];
    $deskripsi_buku = $data['deskripsi_buku'];
    $penulis        = $data['penulis'];
    $tahun_terbit   = $data['tahun_terbit'];
    $id_kategori    = $data['id_kategori'];
    $tanggal        = date('Y-m-d H:i:s');

    $gambarLama = $data['gambarLama'];
    $folder = 'dist/assets/img/';

    // apakah user upload gambar baru?
    if($_FILES['gambar']['error'] === 4){
        $gambar = $gambarLama;
    } else {

        // upload gambar baru
        $gambar = upload_gambar($judul);
        if(!$gambar){
            return false;
        }

        // hapus gambar lama
        if(file_exists($folder . $gambarLama)){
            unlink($folder . $gambarLama);
        }
    }

    $query = "UPDATE buku SET
                judul = '$judul',
                deskripsi_buku = '$deskripsi_buku',
                penulis = '$penulis',
                gambar = '$gambar',
                tanggal_input = '$tanggal',
                tahun_terbit = '$tahun_terbit',
                id_kategori = '$id_kategori'
                WHERE id_buku = '$id_buku'";

    mysqli_query($conn, $query);

    return mysqli_affected_rows($conn);
}

// fungsi untuk menambahkan data kategori
function tambah_kategori($data){
    global $conn;
    
    $nama_kategori = $data['nama_kategori'];

    $query = "INSERT INTO kategori (nama_kategori)
                  VALUES ('$nama_kategori')
                 ";
    mysqli_query($conn, $query);

    return mysqli_affected_rows($conn);    
}

// fungsi untuk menghapus data kategori
function hapus_kategori($id){
    global $conn;

    $query = "DELETE FROM kategori WHERE id_kategori = $id";

    $result = mysqli_query($conn, $query);
    return mysqli_affected_rows($conn);    
}

// fungsi untuk mengubah data kategori
function ubah_kategori($data){
    global $conn;

    $id_kategori = $data['id_kategori'];
    $nama_kategori = $data['nama_kategori'];

    // tanggal
    $tanggal = date('Y-m-d H:i:s');

    $query = "UPDATE kategori SET
                nama_kategori = '$nama_kategori',
                tanggal_input = '$tanggal'
              WHERE id_kategori = '$id_kategori'";

    mysqli_query($conn, $query);

    return mysqli_affected_rows($conn);
}

//FUNGSI UNTUK REGISTER
function register($data_register){
    global $conn;


    // kita tampung dulu data-data yang dikirimkan dari file register.php melalui $data_register ke dalam variabel
   
    $username = strtolower($data_register['username']);
    $email = $data_register['email'];
    $password = mysqli_real_escape_string($conn, $data_register['password']);
   


    // cek username atau email sudah ada atau belum
    $check = mysqli_query($conn, 
        "SELECT * FROM user 
         WHERE username = '$username' OR email = '$email'"
    );

    if(mysqli_num_rows($check) > 0){
    return "username atau email sudah terdaftar, gunakan yang lain";
    }

    if(strlen($password) < 8){
        return "password harus mengandung minimal 8 karakter";
    }

    // enkripsi password
    $password = password_hash($password, PASSWORD_DEFAULT);


    // tambahkan userbaru ke database
    mysqli_query($conn, "INSERT INTO user (id_user, username, email, password) 
    VALUES
    ('', '$username', '$email', '$password')");
   
    return true;
}

//FUNGSI UNTUK LOGIN
function login($data){
    global $conn;


    $username = $data['username'];
    $password = $data['password'];


    // cek username sudah ada atau belum
    $query = "SELECT * FROM user WHERE username = '$username'";
    $result = mysqli_query($conn, $query);


    // var_dump($result);
    // die;


     // Cek user ada atau tidak
    if(mysqli_num_rows($result) === 1){
        $row = mysqli_fetch_assoc($result);


        // var_dump($row);
        // die;


        // Verify password
        if(password_verify($password, $row["password"])) {
            // echo "masuk sini";
            $_SESSION['login'] = true;
            $_SESSION['username'] = $row['username'];
            return true;
        } else {
            // echo "tidak masuk";
            return "Password salah!";
        }


    } else {
        return "Username tidak ditemukan!"; // username tidak ditemukan
    }
   
}



// fungsi untuk upload gambar
function upload_gambar($judul) {


    // setting gambar
    $namaFile = $_FILES['gambar']['name'];
    $ukuranFile = $_FILES['gambar']['size'];
    $error = $_FILES['gambar']['error'];
    $tmpName = $_FILES['gambar']['tmp_name'];


    // cek apakah tidak ada gambar yang diupload
    if( $error === 4 ) {
        echo "<script>
                alert('pilih gambar terlebih dahulu!');
              </script>";
        return false;
    }


    // cek apakah yang diupload adalah gambar
    $ekstensiGambarValid = ['jpg', 'jpeg', 'png'];
    $ekstensiGambar = explode('.', $namaFile);
    $ekstensiGambar = strtolower(end($ekstensiGambar));
    if( !in_array($ekstensiGambar, $ekstensiGambarValid) ) {
        echo "<script>
                alert('yang anda upload bukan gambar!');
              </script>";
        return false;
    }


    // cek jika ukurannya terlalu besar
    // maks --> 2MB
    if( $ukuranFile > 2000000 ) {
        echo "<script>
                alert('ukuran gambar terlalu besar!');
              </script>";
        return false;
    }


    // lolos pengecekan, gambar siap diupload
    // generate nama gambar baru
    $namaFileBaru = $judul;
    $namaFileBaru .= '.';
    $namaFileBaru .= $ekstensiGambar;


    move_uploaded_file($tmpName, 'dist/assets/img/' . $namaFileBaru);


    return $namaFileBaru;
}
?>