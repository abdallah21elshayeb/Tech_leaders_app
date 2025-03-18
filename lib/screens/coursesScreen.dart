import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_test/widgets/course_details.dart';
import 'package:tech_test/widgets/courses_card.dart';

import '../Models/course_details.dart';
import '../provider/courseModel.dart';

class CoursesScreen extends StatefulWidget {
  CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
// assets/images/robot.png
//   var _coursesData = [
//     CourseDetails(
//       'Robot Course',
//       'assets/images/robot.png',
//       '25',
//       'Karim Elwaly',
//       '500',
//     ),
//     CourseDetails('Mobile App', 'assets/images/flutter.png', '30',
//         'Abdallah Elshayeb', '600'),
//     CourseDetails(
//         'Web App', 'assets/images/web.png', '40', 'Yassin Mohamed', '400'),
//     CourseDetails('Python Course', 'assets/images/python.png', '25',
//         'Malek Mohamed', '300'),
//   ];
  List<CourseDetails> _coursesData = [];
  bool _isLoading = true;
  bool isFavorite = false;

  final List<CourseDetails> favoriteCourses = [];

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    final db = FirebaseFirestore.instance;
    try {
      QuerySnapshot snapshot = await db.collection('academyCourse').get();
      if (snapshot.docs.isNotEmpty) {
        List<CourseDetails> loadedCourses = [];

        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          List<dynamic> courseList = data['course'] ?? [];

          for (var courseData in courseList) {
            loadedCourses.add(CourseDetails(
              courseData['title'],
              courseData['image'],
              '0',
              courseData['instructor'],
              courseData['fees'],
              courseData['location'],
            ));
          }
        }
        setState(() {
          _coursesData = loadedCourses;
          _isLoading = false;
        });
        print('course fetch data: $_coursesData');
      } else {
        setState(() {
          _isLoading = false;
        });
        print('no courses found');
      }
    } catch (e) {
      print('failled to fetch course details: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void handleFavoriteChange(int index, bool isFavorite, BuildContext context) {
//** not understand this part **//

    final course = _coursesData[index];
    final courseModel = Provider.of<CourseModel>(context, listen: false);

    courseModel.toggleCourses(course);

    setState(() {
      course.isFavorite = isFavorite;
      // _coursesData[index].isFavorite = isFavorite;
      // if (isFavorite) {
      //   favoriteCourses.add(_coursesData[index]);
      //   Provider.of<CourseModel>(context, listen: false).savedCourses();
      // } else {
      //   favoriteCourses.remove(_coursesData[index]);
      // }
    });
    print('provider');
    print(courseModel.favoriteCourses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text('Courses Screen'),
                    GridView.builder(
                      itemCount: _coursesData.length,
                      shrinkWrap: true,
                      // padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 288,
                      ),
                      itemBuilder: (_, index) {
                        final course = _coursesData[index];
                        return CoursesCard(
                          courseName: course.courseName,
                          imgUrl: course.imgUrl,
                          offerPercent: course.offerPercent,
                          instructorName: course.instructorName,
                          courseFees: course.courseFees,
                          onFavoriteChanged: (isFavorite) =>
                              handleFavoriteChange(index, isFavorite, context),
                          onTabDetails: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CourseDetailsScreen(
                                        imgUrl: course.imgUrl,
                                        courseName: course.courseName,
                                        courseDescription:
                                            course.instructorName,
                                        courseLocation:
                                            course.courseLocation)));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
