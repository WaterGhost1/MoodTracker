import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/core/routes/app_router.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mood_tracker/core/routes/app_router.dart';

class MoodEntryScreen extends StatefulWidget {
  const MoodEntryScreen({super.key});

  @override
  State<MoodEntryScreen> createState() => _MoodEntryScreenState();
}

class _MoodEntryScreenState extends State<MoodEntryScreen> {
  final List<String> imagePath = [
    'assets/images/anger.jpg',
    'assets/images/disgust.jpg',
    'assets/images/fear.jpg',
    'assets/images/sad.jpg',
    'assets/images/shy.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      fit: StackFit.loose,
      children: [
        Center(
          widthFactor: double.infinity,
          child: CarouselSlider(
            items:
                imagePath.map((path) {
                  return SizedBox(
                    width: screenWidth,
                    child: Image.asset(path, fit: BoxFit.cover),
                  );
                }).toList(),
            options: CarouselOptions(
              height: screenHeight,
              enlargeCenterPage: false, // full screen
              viewportFraction: 1.0, // one image at a time
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            context.go(Routes.homeScreen);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        Positioned(
          bottom: 30,
          left: screenWidth / 2 - 40,
          child: ElevatedButton(onPressed: () {}, child: Text('Select')),
        ),
      ],
    );
  }
}


// return Center(
//       child: ElevatedButton( 
//         onPressed: () {
//           context.go(Routes.homeScreen);
//         },
//         child: Text('click'),
//       ),
//     );