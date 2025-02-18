import 'package:flutter/material.dart';
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
        location: _courseLocationController.text.trim(),
        fees: _courseFeesController.text.trim(),
      );
      _courses.add(newCourse); // Add the course to the list
      print("Course added: ${newCourse.toMap()}");
    }
  }

  Future<void> _submitForm() async {
    final db = FirebaseFirestore.instance;
    try {
      final courseList = _courses.map((course) => course.toMap()).toList();
      await db.collection("academyCourse").add({'course': courseList});
      print('course Details saved successfully!!');
    } catch (e) {
      print('failled to save course details: $e');
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _courseLocationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Location.';
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
