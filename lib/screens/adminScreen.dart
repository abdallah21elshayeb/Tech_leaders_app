import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../Models/course_save.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final _courseTitleController = TextEditingController();
  final _instructorNameController = TextEditingController();
  final _courseTimeController = TextEditingController();
  final _courseLocationController = TextEditingController();
  final _courseFeesController = TextEditingController();
  String? _selectedLocation;
  final List<String> _locations = ['Zayed', 'October', 'Mohandsen'];
  final List<Course> _courses = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveCourse() {
    if (_formKey.currentState!.validate()) {
      final newCourse = Course(
        image: _image,
        title: _courseTitleController.text.trim(),
        instructor: _instructorNameController.text.trim(),
        time: _courseTimeController.text.trim(),
        location: _selectedLocation!,
        fees: _courseFeesController.text.trim(),
      );
      _courses.add(newCourse); // Add the course to the list
      print("Course added: ${newCourse.toMap()}");
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final db = FirebaseFirestore.instance;
      try {
        final courseList = _courses.map((course) => course.toMap()).toList();
        await db.collection("academyCourse").add({'course': courseList});
        Fluttertoast.showToast(
          msg: 'course Details saved successfully!!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 14,
        );
        _courseTitleController.clear();
        _instructorNameController.clear();
        _courseTimeController.clear();
        _courseFeesController.clear();
        setState(() {
          _image = null;
          _selectedLocation = null; // Reset dropdown selection
        });
        _courses.clear();
      } catch (e) {
        print('failled to save course details: $e');
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Please fill all fields before submitting!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }

  @override
  void dispose() {
    _courseTitleController.dispose();
    _instructorNameController.dispose();
    _courseTimeController.dispose();
    _courseLocationController.dispose();
    _courseFeesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Course Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined),
                              Text('Drop image here')
                            ],
                          ),
                        )
                      : Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _courseTitleController,
                decoration: const InputDecoration(
                  labelText: 'Course Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a course title.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _instructorNameController,
                decoration: const InputDecoration(
                  labelText: 'Instructor Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Instructor Name.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _courseTimeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Time.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Dropdown List for Location
              DropdownButtonFormField<String>(
                value: _selectedLocation ?? _locations.first,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a location';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _courseFeesController,
                decoration: const InputDecoration(
                  labelText: 'Fees',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Fees.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _saveCourse();
                  _submitForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                child: const Text("Submit Course"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
