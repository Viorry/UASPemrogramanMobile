import 'package:antiran_rumah_sakit/pages/patient_registration_success_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/loading_util.dart';

class PatientRegistrationForm extends StatefulWidget {
  const PatientRegistrationForm({super.key});

  @override
  PatientRegistrationFormPage createState() => PatientRegistrationFormPage();
}

class PatientRegistrationFormPage extends State<PatientRegistrationForm> {
  static const List<String> genderList = ['Laki-laki', 'Perempuan'];

  DateTime? selectedDate;
  String? dropdownValue;

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final namaInputController = TextEditingController();
  final tempatLahirInputController = TextEditingController();
  final tglLahirInputController = TextEditingController();
  final jkInputController = TextEditingController();
  final alamatInputController = TextEditingController();
  final agamaInputController = TextEditingController();
  final namaPJInputController = TextEditingController();
  final telpInputController = TextEditingController();
  final noRMInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingUtil()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade100,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              title: const Text(
                "Form Pendaftaran Pasien",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nama',
                            labelStyle: MaterialStateTextStyle.resolveWith(
                                (Set<MaterialState> states) {
                              final Color color =
                                  states.contains(MaterialState.focused)
                                      ? Colors.black
                                      : Colors.white;
                              return TextStyle(color: color);
                            }),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            fillColor: const Color(0xff02968A),
                            filled: true,
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan nama';
                            }
                            return null;
                          },
                          controller: namaInputController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: tempatLahirInputController,
                          decoration: InputDecoration(
                            labelText: 'Tempat lahir',
                            labelStyle: MaterialStateTextStyle.resolveWith(
                                (Set<MaterialState> states) {
                              final Color color =
                                  states.contains(MaterialState.focused)
                                      ? Colors.black
                                      : Colors.white;
                              return TextStyle(color: color);
                            }),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            fillColor: const Color(0xff02968A),
                            filled: true,
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan tempat lahir';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: tglLahirInputController,
                          decoration: InputDecoration(
                            labelText: 'Tanggal lahir',
                            labelStyle: MaterialStateTextStyle.resolveWith(
                                (Set<MaterialState> states) {
                              final Color color =
                                  states.contains(MaterialState.focused)
                                      ? Colors.black
                                      : Colors.white;
                              return TextStyle(color: color);
                            }),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            fillColor: const Color(0xff02968A),
                            filled: true,
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan tanggal lahir';
                            }
                            return null;
                          },
                          readOnly: true,
                          onTap: selectDateModal,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Jenis Kelamin',
                            labelStyle: MaterialStateTextStyle.resolveWith(
                                (Set<MaterialState> states) {
                              final Color color =
                                  states.contains(MaterialState.focused)
                                      ? Colors.black
                                      : Colors.white;
                              return TextStyle(color: color);
                            }),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            fillColor: const Color(0xff02968A),
                            filled: true,
                          ),
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              jkInputController.text = newValue!;
                            });
                          },
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          dropdownColor: const Color(0xff02968A),
                          iconEnabledColor: Colors.white,
                          items: genderList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pilih jenis kelamin';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: alamatInputController,
                            decoration: InputDecoration(
                              labelText: 'Alamat',
                              labelStyle: MaterialStateTextStyle.resolveWith(
                                  (Set<MaterialState> states) {
                                final Color color =
                                    states.contains(MaterialState.focused)
                                        ? Colors.black
                                        : Colors.white;
                                return TextStyle(color: color);
                              }),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              fillColor: const Color(0xff02968A),
                              filled: true,
                            ),
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan alamat';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: agamaInputController,
                            decoration: InputDecoration(
                              labelText: 'Agama',
                              labelStyle: MaterialStateTextStyle.resolveWith(
                                  (Set<MaterialState> states) {
                                final Color color =
                                    states.contains(MaterialState.focused)
                                        ? Colors.black
                                        : Colors.white;
                                return TextStyle(color: color);
                              }),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              fillColor: const Color(0xff02968A),
                              filled: true,
                            ),
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan agama';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: namaPJInputController,
                            decoration: InputDecoration(
                              labelText: 'Nama Penanggungjawab',
                              labelStyle: MaterialStateTextStyle.resolveWith(
                                  (Set<MaterialState> states) {
                                final Color color =
                                    states.contains(MaterialState.focused)
                                        ? Colors.black
                                        : Colors.white;
                                return TextStyle(color: color);
                              }),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              fillColor: const Color(0xff02968A),
                              filled: true,
                            ),
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan nama penanggungjawab';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: telpInputController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Nomor telepon',
                              labelStyle: MaterialStateTextStyle.resolveWith(
                                  (Set<MaterialState> states) {
                                final Color color =
                                    states.contains(MaterialState.focused)
                                        ? Colors.black
                                        : Colors.white;
                                return TextStyle(color: color);
                              }),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              fillColor: const Color(0xff02968A),
                              filled: true,
                            ),
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan nomor telepon';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: noRMInputController,
                            decoration: InputDecoration(
                              labelText: 'No RM (Bila Ada)',
                              labelStyle: MaterialStateTextStyle.resolveWith(
                                  (Set<MaterialState> states) {
                                final Color color =
                                    states.contains(MaterialState.focused)
                                        ? Colors.black
                                        : Colors.white;
                                return TextStyle(color: color);
                              }),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              fillColor: const Color(0xff02968A),
                              filled: true,
                            ),
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              // Perform the submit action
                              confirmationModal(context);
                            }
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
                            'Daftar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Future<void> selectDateModal() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      String formatedPickedDate = DateFormat('dd MM yyyy').format(pickedDate);
      setState(() {
        tglLahirInputController.text = formatedPickedDate;
      });
    }
  }

  Future<void> saveToFirebase() async {
    setState(() {
      isLoading = true;
    });

    String alamat = await getCurrentPosition();
    if (alamat == 'error'){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ijin akses lokasi ditolak. Anda tidak akan dapat mendaftar!")),
      );
      return;
    }

    try {
      DatabaseReference dataRef = FirebaseDatabase.instance.ref().child('data');
      DatabaseReference antrianRef =
          FirebaseDatabase.instance.ref().child('antrian');

      DataSnapshot getAntrian = await antrianRef.get();

      int? antrian = 0;
      if (getAntrian.exists) {
        antrian = getAntrian.value as int?;
        if (antrian == null) {
          antrian = 0;
          await antrianRef.set(antrian);
        }
        antrian += 1;
        await antrianRef.set(antrian);
      } else {
        antrian += 1;
        await antrianRef.set(antrian);
      }

      DatabaseReference newDataRef = dataRef.push();

      Map<String, dynamic> data = {
        "nama": namaInputController.text,
        "tempat_lahir": tempatLahirInputController.text,
        "tanggal_lahir": tglLahirInputController.text,
        "jenis_kelamin": jkInputController.text,
        "alamat": alamatInputController.text,
        "agama": agamaInputController.text,
        "nama_penanggungjawab": namaPJInputController.text,
        "nomor_telepon": telpInputController.text,
        "no_rm": noRMInputController.text,
        "no_antrian": antrian,
        "alamat_gps": alamat
      };

      await newDataRef.set(data);

      SharedPreferences spStorage = await SharedPreferences.getInstance();
      spStorage.setInt('antrian', antrian);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const PatientRegistrationSuccess()));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal! Coba lagi!")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ijin akses lokasi diperlukan untuk mengakses aplikasi!")),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ijin akses lokasi diperlukan untuk mengakses aplikasi!")),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ijin akses lokasi ditolak. Anda tidak akan dapat mendaftar!")),
      );
      return false;
    }
    return true;
  }

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

  Future<void> confirmationModal(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text(
                    "Nama: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(namaInputController.text)
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "Tempat Lahir: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(tempatLahirInputController.text)
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "Tanggal Lahir: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(tglLahirInputController.text)
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "Jenis Kelamin: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(jkInputController.text)
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "Alamat: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(alamatInputController.text)
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "Agama: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(agamaInputController.text)
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "Nama Penanggungjawab: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(namaPJInputController.text)
                ],
              ),
              Row(
                children: <Widget>[
                  const Text(
                    "Nomor Telepon: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(telpInputController.text)
                ],
              ),
              Row(
                children: [
                  if (noRMInputController.text.isNotEmpty)
                    const Text(
                      "No RM: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  if (noRMInputController.text.isNotEmpty)
                    Text(noRMInputController.text),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
          ],
        );
      },
    );
  }
}
