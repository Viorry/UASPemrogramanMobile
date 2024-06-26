import 'package:antiran_rumah_sakit/pages/patient_registration_form_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientRegistrationSuccess extends StatefulWidget {
  const PatientRegistrationSuccess({super.key});

  @override
  PatientRegistrationSuccessPage createState() =>
      PatientRegistrationSuccessPage();
}

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 200.0,
          ),
          const Text(
            "TERIMA KASIH",
            style: TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            "DATA ANDA SUDAH TERSIMPAN",
            style: TextStyle(
              fontSize: 45.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            "NOMOR ANTRIAN ANDA ADALAH",
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "...${antrian.toString()}...",
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PatientRegistrationForm()));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: const Color(0xff1B8854),
            ),
            child: const Text(
              'Daftar Lagi',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    )));
  }
}
