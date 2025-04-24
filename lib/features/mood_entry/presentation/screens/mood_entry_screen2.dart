import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/core/routes/app_router.dart';
import 'package:mood_tracker/features/mood_entry/presentation/widgets/textfield.dart';

class AddNewEntry extends StatefulWidget {
  const AddNewEntry({super.key});

  @override
  State<AddNewEntry> createState() => _AddNewEntryState();
}

class _AddNewEntryState extends State<AddNewEntry> {
  final List<String> imagePath2 = [
    'assets/imagesnoBg/anger.png',
    'assets/imagesnoBg/disgust.png',
    'assets/imagesnoBg/fear.png',
    'assets/imagesnoBg/sad.png',
    'assets/imagesnoBg/joy.png',
    'assets/imagesnoBg/embarassment.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              'WHAT ARE YOU FEELING?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: CarouselSlider(
              items:
                  imagePath2.map((path) {
                    return Container(
                      // color: Colors.amber,
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.asset(path, fit: BoxFit.cover),
                    );
                  }).toList(),
              options: CarouselOptions(
                enlargeCenterPage: false,
                viewportFraction: 1,
              ),
            ),
          ),

          Padding(padding: const EdgeInsets.only(top: 20), child: TitleTF()),

          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: DescriptionTF(),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black, width: 1),
                minimumSize: Size(150, 47),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'ADD',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          IconButton(
            onPressed: () => context.go(Routes.homeScreen),
            icon: Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
