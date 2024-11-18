import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DoctorForm(),
    );
  }
}

class DoctorForm extends StatefulWidget {
  const DoctorForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoctorFormState createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expertiseController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  Future<void> addDoctor() async {
    String name = _nameController.text;
    String expertise = _expertiseController.text;
    String address = _addressController.text;
    double? rating = double.tryParse(_ratingController.text);
    double? latitude = double.tryParse(_latitudeController.text);
    double? longitude = double.tryParse(_longitudeController.text);

    Map<String, dynamic> doctorData = {
      'name': name,
      'expertise': expertise,
      'address': address,
      'rating': rating,
      if (latitude != null && longitude != null)
        'location': {
          'latitude': latitude,
          'longitude': longitude,
        }
    };

    await FirebaseFirestore.instance.collection('doctors').add(doctorData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adding Doctors')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Doctor Name'),
              ),
              TextField(
                controller: _expertiseController,
                decoration: const InputDecoration(labelText: 'Expertise'),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: _ratingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Rating'),
              ),
              TextField(
                controller: _latitudeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: _longitudeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Longitude'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const ValueKey('add doctor'),
                onPressed: () {
                  addDoctor();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Doctor added successfully!')),
                  );
                },
                child: const Text('Add Doctor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
