import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/courseModel.dart'; // Import the CourseModel

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Screen')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('Favorite Courses:', style: TextStyle(fontSize: 24)),
              // Listen to changes in CourseModel
              Consumer<CourseModel>(
                builder: (context, courseModel, child) {
                  final favoriteCourses = courseModel.favoriteCourses;

                  // Check if there are any favorite courses
                  if (favoriteCourses.isEmpty) {
                    return const Text(
                      'No favorite courses yet!',
                      style: TextStyle(fontSize: 18),
                    );
                  } else {
                    // Display favorite courses in a ListView
                    return ListView.builder(
                      shrinkWrap: true,
                      // Use shrinkWrap to make the ListView not take up full height
                      physics: const NeverScrollableScrollPhysics(),
                      // Disable scroll in the ListView
                      itemCount: favoriteCourses.length,
                      itemBuilder: (context, index) {
                        final course = favoriteCourses[index];
                        return ListTile(
                          title: Text(
                            course.courseName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          subtitle: Text(
                            course.instructorName,
                          ),
                          leading: Image.asset(
                            course.imgUrl,
                            width: 80,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              courseModel.removeCourses(course);
                              print(courseModel.favoriteCourses);
                            },
                            icon: const Icon(Icons.delete_forever_sharp, color: Colors.red,),
                          ),

                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
