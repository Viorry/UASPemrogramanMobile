# antrian_rumah_sakit

Aplikasi Antrian Rumah Sakit 
Aplikasi ini membantu rumah sakit untuk mendata data pasien dan sekaligus memberikan nomor antrian kepada pasien.

![Screenshot Figma](https://github.com/Viorry/UASPemrogramanMobile/blob/main/SS/SS2.jpeg)
![Screenshot Figma](https://github.com/Viorry/UASPemrogramanMobile/blob/main/SS/SS1.jpeg)




Pembahasan (menjelaskan fungsi dari setiap komponen yang diimplementasikan, beserta dengan potongan source code yang digunakan dalam menyusun component tersebut): 

Implementasi API Post Request
Data yang dikirim dalam permintaan POST berupa form data, data ini berupa nama, tanggal lahir, tempat lahir, jenis kelamin, alamat, agama, nama penanggung jawab, no tlp, no rekam medis(RM). Permintaan POST dikirim dari klien ke server. Setelah server memproses permintaan, respons dikirim kembali ke klien. Respons ini berisi status keberhasilan, pesan kesalahan, selanjutnya validasi untuk memastikan bahwa data yang dikirim dan diterima sesuai dengan yang diharapkan.
Source Code:

![Screenshot Code](https://github.com/Viorry/UASPemrogramanMobile/blob/main/SS/POST%20Req.jpeg)



Implementasi API Get Request
Untuk implementasi Get Request yang pertama ada di pengambilan data username dan password yang sudah dibuat oleh client, jadi mereka bisa login. Untuk yang kedua ada di pemberian nomor antrian yang diambil dari data di firebase.
Form Login, Source Code:

![Screenshot Code](https://github.com/Viorry/UASPemrogramanMobile/blob/main/SS/GET%20Req%2C%20Login.jpeg)


Form nomor antrian, Source Code:

![Screenshot Code](https://github.com/Viorry/UASPemrogramanMobile/blob/main/SS/GET%20Req%2C%20No%20Antrian.jpeg)




Implementasi Firebase
Implementasi backend firebase untuk menyimpan data yang sudah dimasukan oleh pasien dan untuk mengolah data pasien.
Source Code:

![Screenshot Code](https://github.com/Viorry/UASPemrogramanMobile/blob/main/SS/Firebase.jpeg)



Implementasi Kamera
Meminta perizinan kepada pengguna atau  pasien untuk membuka kamera di hp mereka.
Source Code:

![Screenshot Code](https://github.com/Viorry/UASPemrogramanMobile/blob/main/SS/Kamera.jpeg)



Implementasi Lokasi
Meminta perizinan kepada pengguna atau  pasien untuk mengakses maps di hp mereka.
Source Code:

![Screenshot Code](https://github.com/Viorry/UASPemrogramanMobile/blob/main/SS/Lokasi.jpeg)




Petunjuk instalasi project
Buka link : https://github.com/Viorry/UASPemrogramanMobile

Download file-nya

Ekstrak file

Buka file menggunakan aplikasi yang biasa digunakan


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
