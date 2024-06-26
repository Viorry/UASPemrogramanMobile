# antrian_rumah_sakit

Aplikasi Antrian Rumah Sakit 
Aplikasi ini membantu rumah sakit untuk mendata data pasien dan sekaligus memberikan nomor antrian kepada pasien.

![Screenshot Figma](https://github.com/Viorry/UASPemrogramanMobile/blob/main/SS/SS2.jpeg)
![Screenshot Figma](https://github.com/Viorry/UASPemrogramanMobile/blob/main/SS/SS1.jpeg)




Pembahasan (menjelaskan fungsi dari setiap komponen yang diimplementasikan, beserta dengan potongan source code yang digunakan dalam menyusun component tersebut): 

Implementasi API Post Request
Data yang dikirim dalam permintaan POST berupa form data, data ini berupa nama, tanggal lahir, tempat lahir, jenis kelamin, alamat, agama, nama penanggung jawab, no tlp, no rekam medis(RM). Permintaan POST dikirim dari klien ke server. Setelah server memproses permintaan, respons dikirim kembali ke klien. Respons ini berisi status keberhasilan, pesan kesalahan, selanjutnya validasi untuk memastikan bahwa data yang dikirim dan diterima sesuai dengan yang diharapkan.
Source Code:

TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Simpan'),
              onPressed: () async {
                Navigator.of(context).pop();
                await saveToFirebase();
              },
            ),



Implementasi API Get Request
Untuk implementasi Get Request yang pertama ada di pengambilan data username dan password yang sudah dibuat oleh client, jadi mereka bisa login. Untuk yang kedua ada di pemberian nomor antrian yang diambil dari data di firebase.
Form Login, Source Code:

class LoginPage extends State<Login> {
  final auth = FirebaseAuth.instance;
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isLoading = false;


  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }


Form nomor antrian, Source Code:

class PatientRegistrationSuccessPage extends State<PatientRegistrationSuccess> {
  int antrian = 0;


  void getAntrian() async {
    SharedPreferences spStorage = await SharedPreferences.getInstance();
    setState(() {
      antrian = spStorage.getInt('antrian')!;
    });
  }


  @override
  void initState() {
    super.initState();
    getAntrian();
  }




Implementasi Firebase
Implementasi backend firebase untuk menyimpan data yang sudah dimasukan oleh pasien dan untuk mengolah data pasien.
Source Code:

import 'package:antiran_rumah_sakit/pages/home_page.dart';
import 'package:antiran_rumah_sakit/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}



Implementasi Kamera
Meminta perizinan kepada pengguna atau  pasien untuk membuka kamera di hp mereka.
Source Code:

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});


  @override
  QRCodeScannerPage createState() => QRCodeScannerPage();
}


class QRCodeScannerPage extends State<QRCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }



Implementasi Lokasi
Meminta perizinan kepada pengguna atau  pasien untuk mengakses maps di hp mereka.
Source Code:

Future<String> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    late String alamat;


    if (!hasPermission) return 'error';
    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Placemark placemark = (await placemarkFromCoordinates(position.latitude, position.longitude))[0];
      alamat = '${placemark.street}, ${placemark.subLocality}, ${placemark.subAdministrativeArea}, ${placemark.postalCode}';
    } catch (e) {
      print(e as String);
      return 'error';
    }
    return alamat;
  }




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
