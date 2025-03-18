import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen(
      {super.key,
      required this.imgUrl,
      required this.courseName,
      required this.courseDescription,
      required this.courseLocation});

  final String imgUrl;
  final String courseName;
  final String courseDescription;
  final String courseLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Image.asset(imgUrl),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Course Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              const Icon(Icons.book),
              SizedBox(width: 5,),
              Text(': ${courseName}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),

            ],
          ),

          // book , description ,location_on
          const SizedBox(
            height: 20,
          ),
          const Text('Course Description',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

          Text(courseDescription,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
          const SizedBox(
            height: 20,
          ),
          const Text('Course Location',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

          Text(courseLocation,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
        ],
      ),
    );
  }
}
