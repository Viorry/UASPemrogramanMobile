import 'package:antiran_rumah_sakit/pages/patient_registration_form_page.dart';
import 'package:antiran_rumah_sakit/pages/qrcode_scanner_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/loading_util.dart';
import 'login_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<Home> {
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingUtil()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.grey.shade100,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              title: const Text(
                "Antrian Rumah Sakit",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
              tooltip: 'Increment',
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const QRCodeScanner()));
              },
              child: const Icon(Icons.camera_alt, color: Colors.white, size: 28),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PatientRegistrationForm()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: const Color(0xff1B8854),
                    ),
                    child: const Text(
                      'Daftar Pasien',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: logout,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: const Color(0xffff0000),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ));
  }

  void logout() {
    setState(() {
      isLoading = true;
    });

    auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));

    setState(() {
      isLoading = false;
    });
  }
}
