import 'dart:io';

class Course {
  File? image;
  String title;
  String instructor;
  String time;
  String location;
  String fees;

  Course({
    this.image,
    required this.title,
    required this.instructor,
    required this.time,
    required this.location,
    required this.fees,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'instructor': instructor,
      'time': time,
      'location': location,
      'fees': fees,
      'image': image != null ? image!.path : null, // Save image path
    };
  }
}
