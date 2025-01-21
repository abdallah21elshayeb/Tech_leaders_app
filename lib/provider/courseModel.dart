import 'package:flutter/foundation.dart';
import '../Models/course_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel with ChangeNotifier {
  List<CourseDetails> _favoriteCourses = [];

  List<CourseDetails> get favoriteCourses => _favoriteCourses;

  void toggleCourses(CourseDetails course) {
    if (_favoriteCourses.contains(course)) {
      _favoriteCourses.remove(course);
    } else {
      _favoriteCourses.add(course);
    }
    notifyListeners();
    // saveToFirebase();
    getFavoriteCourses();
  }

  void removeCourses(CourseDetails course) {
    _favoriteCourses.remove(course);
    notifyListeners();
    // saveToFirebase();
    getFavoriteCourses();
  }

  void savedCourses(List<CourseDetails> courses) {
    _favoriteCourses = courses;
    notifyListeners();
    // saveToFirebase();
    getFavoriteCourses();
  }

  Future<void> saveToFirebase() async {
    final db = FirebaseFirestore.instance;

    try {
      final courseList =
          _favoriteCourses.map((course) => course.toMap()).toList();
      // await db
      //     .collection('favoriteCourses')
      //     .doc('cebPEoyFomKHdTeZxTZg')
      //     .set({'favorite_course': courseList});
      await db
          .collection("favoriteCourses")
          .add({'favorite_course': courseList});
      print('course Details saved successfully!!');
    } catch (e) {
      print('failled to save course details: $e');
    }
  }

  Future<void> getFavoriteCourses() async {
    final db = FirebaseFirestore.instance;
    try {
      final favouriteCourses = await db
          .collection("favoriteCourses")
          .doc('UFzz3byNKwwKWreNK0S0')
          .get();
      if (favouriteCourses.exists && favouriteCourses.data() != null) {
        final data = favouriteCourses.data();
        // final List<dynamic> courses = data['favorite_courses'];
        final List<dynamic> courses = data?['favorite_courses'] ?? [];
        _favoriteCourses = courses
            .map((course) =>
                CourseDetails.fromMap(course as Map<String, dynamic>))
            .toList();

        notifyListeners();
        print('courses get successfully!!');
        print(data);
      }
    } catch (e) {
      print('failed to get courses: $e');
    }
  }
}
