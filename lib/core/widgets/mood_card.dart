import 'package:flutter/material.dart';

class MoodCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final Color moodColor;
  const MoodCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.moodColor,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(style: BorderStyle.solid),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(height: 90, width: 10, color: moodColor),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // color: Colors.purple,
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.start,

                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$date $time',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 12),
                          ),
                          // IconButton(
                          //   onPressed: () {},
                          //   iconSize: 20,
                          //   // alignment: Alignment.center,
                          //   icon: Icon(Icons.star_border_outlined),
                          // ),
                        ],
                      ),
                    ),

                    Container(
                      height: 40,
                      width: 400,
                      // color: Colors.blue,
                      child: Text(
                        description,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
