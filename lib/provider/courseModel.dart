import 'package:flutter/foundation.dart';

import '../Models/course_details.dart';

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
  }

  void savedCourses(List<CourseDetails> courses) {
    _favoriteCourses = courses;
    notifyListeners();
  }
}
