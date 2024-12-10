import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final coursesData = [
    CourseDetails(
        'Robot Course', 'assets/images/robot.png', '25', 'Karim Elwaly', '500'),
    CourseDetails('Mobile App', 'assets/images/flutter.png', '30',
        'Abdallah Elshayeb', '600'),
    CourseDetails(
        'Web App', 'assets/images/web.png', '40', 'Yassin Mohamed', '400'),
    CourseDetails('Python Course', 'assets/images/python.png', '25',
        'Malek Mohamed', '300'),
  ];
  bool isFavorite = false;

  final List<CourseDetails> favoriteCourses = [];

  void handleFavoriteChange(int index, bool isFavorite, BuildContext context) {
//** not understand this part **//

    final course = coursesData[index];
    final courseModel = Provider.of<CourseModel>(context, listen: false);

    courseModel.toggleCourses(course);


    setState(() {
      course.isFavorite = isFavorite;
      // coursesData[index].isFavorite = isFavorite;
      // if (isFavorite) {
      //   favoriteCourses.add(coursesData[index]);
      //   Provider.of<CourseModel>(context, listen: false).savedCourses();
      // } else {
      //   favoriteCourses.remove(coursesData[index]);
      // }
    });
    print('provider');
    print(courseModel.favoriteCourses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('Courses Screen'),
              GridView.builder(
                itemCount: coursesData.length,
                shrinkWrap: true,
                // padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 288,
                ),
                itemBuilder: (_, index) {
                  final course = coursesData[index];
                  return CoursesCard(
                    courseName: course.courseName,
                    imgUrl: course.imgUrl,
                    offerPercent: course.offerPercent,
                    instructorName: course.instructorName,
                    courseFees: course.courseFees,
                    onFavoriteChanged: (isFavorite) =>
                        handleFavoriteChange(index, isFavorite, context),
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


