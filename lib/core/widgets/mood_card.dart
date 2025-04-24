import 'package:flutter/material.dart';

class MoodCard extends StatelessWidget {
  final String title;
  final String? description;
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

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: screenWidth,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: moodColor, width: 2),
              left: BorderSide(color: moodColor, width: 2),
              right: BorderSide(color: moodColor, width: 4),
              bottom: BorderSide(color: moodColor, width: 5.0),
            ),
            borderRadius: BorderRadius.circular(
              18,
            ), // Optional: Rounded corners
          ),
          child: Card(
            elevation: 0,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18),
            //   side: BorderSide(color: moodColor, style: BorderStyle.solid),
            // ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 90,
                    width: 10,
                    decoration: BoxDecoration(
                      color: moodColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
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

                        SizedBox(
                          height: 40,
                          width: 400,
                          // color: Colors.blue,
                          child: Text(
                            description!,
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
        ),
      ),
    );
  }
}
