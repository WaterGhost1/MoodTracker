import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:mood_tracker/core/models/mood_model.dart';
import 'package:mood_tracker/core/routes/param_models/detail_param.dart';
// import 'package:mood_tracker/core/routes/router/app_router.dart';
import 'package:mood_tracker/core/utils/date_formats.dart';
import 'package:mood_tracker/core/utils/picker.dart';

class DetailScreen extends StatelessWidget {
  // final String date;
  final DetailParam detailParam;
  const DetailScreen({super.key, required this.detailParam});

  @override
  Widget build(BuildContext context) {
    final String? imgPath = Picker.imgPicker(
      name: detailParam.mood?.name ?? 'assets/images2/anger.png',
    );
    'assets/images2/anger.png';
    return Container(
      // color: Color(0xffEF476F),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            detailParam.mood!.name,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 230,
            width: double.infinity,
            child: Image.asset(imgPath!, fit: BoxFit.cover),
          ),

          // Text("Mood: ${mood.name}"),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 45, bottom: 10, top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "DESCRIPTION:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.only(right: 52),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${detailParam.date}  ',
                        style: TextStyle(fontSize: 13),
                      ),
                      Text(
                        DateFormatter.getTime(detailParam.mood!.time),
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DetailCard(moodDetail: detailParam.mood!),
        ],
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  // final Color moodColor;
  final Mood moodDetail;

  const DetailCard({
    super.key,
    required this.moodDetail,
    // required this.moodColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black, width: 2),
          bottom: BorderSide(color: Colors.black, width: 2),
          left: BorderSide(color: Colors.black, width: 2),
          right: BorderSide(color: Colors.black, width: 2),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.all(16),
        child: Text(moodDetail.description ?? 'idk'),
      ),
    );
  }
}
