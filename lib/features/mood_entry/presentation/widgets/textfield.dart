import 'package:flutter/material.dart';

class TitleTF extends StatelessWidget {
  const TitleTF({super.key});

  @override
  Widget build(BuildContext context) {
    final titlecontroller = TextEditingController();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 24),
          width: double.infinity,
          child: Text(
            'TITLE:',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox(
          width: 360,
          child: TextField(
            controller: titlecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DescriptionTF extends StatelessWidget {
  final TextEditingController descriptioncontroller;
  const DescriptionTF({super.key, required this.descriptioncontroller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 24),

          width: double.infinity,
          child: Text(
            'DESCRIPTION:',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox(
          width: 360,
          child: TextFormField(
            controller: descriptioncontroller,
            maxLines: 6,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
