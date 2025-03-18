import 'package:flutter/material.dart';
import 'package:tech_test/widgets/app_bar.dart';
// import 'package:tech_test/widgets/circular_container.dart';
// import 'package:tech_test/widgets/curved_edges.dart';
import 'package:tech_test/widgets/primary_header_container.dart';

import '../services/auth_sevices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _signOut() async {
    await AuthService().signOut(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          PrimaryHeaderContainer(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Technology Leaders Academy',
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                    ],
                  ),
                  actions: [
                    Stack(
                      children: [
                        IconButton(
                          onPressed: _signOut,
                          icon: const Icon(
                            Icons.laptop_chromebook_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset('assets/images/tecg_logo.png',height: 300,)

              ],
            ),
          ),
        ],
      ),
    ));
  }
}

// Center(
// child: Column(
// children: [
// Image.asset(
// 'assets/images/images.jpg',
// width: double.infinity,
// height: 200,
// fit: BoxFit.cover,
// ),
//
// const Padding(
// padding: EdgeInsets.all(8),
// child: Text(
// 'welcome !! to technology leaders Academy,\nTechnology Leaders Academy are the first academy in young generations development and enrichment programs in Giza city since 2013.\nwe aim to develop the necessary future skills of the new generations using project-learning approach-instead of student learning in isolation- through STEM “Science –Technology –Engineering-Math” ,hands on activities ,scientific experiments and international competitions 💪',
// textAlign: TextAlign.center,
// ),
// ),
//
// // Image.asset('assets/images/images.jpg', width: 380, height: 200,),
// ],
// ),
// ),

// SafeArea(
// child: Padding(
// padding: EdgeInsets.all(6),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Align(
// alignment: AlignmentDirectional(0, 4),
// child: ClipRRect(
// borderRadius: BorderRadius.circular(8.0),
// child: Image.asset(
// 'assets/images/images.jpg',
// width: 380,
// height: 200,
// fit: BoxFit.cover,
// ),
// ),
// ),
// const Padding(
// padding: EdgeInsets.all(20),
// child:  Text(
// 'welcome !! to technology leaders Academy,\nTechnology Leaders Academy are the first academy in young generations development and enrichment programs in Giza city since 2013.\nwe aim to develop the necessary future skills of the new generations using project-learning approach-instead of student learning in isolation- through STEM “Science –Technology –Engineering-Math” ,hands on activities ,scientific experiments and international competitions 💪',
// textAlign: TextAlign.center,
// style: TextStyle(
// fontFamily: 'Roboto Mono',
// color: Color(0xFF60533F),
// letterSpacing: 0.0,
// ),
// ),
// ),
// ],
// ),
// ),
// ),
