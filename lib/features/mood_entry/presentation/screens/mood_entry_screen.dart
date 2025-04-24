import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_tracker/features/mood_entry/presentation/bloc/mood_bloc.dart';
import 'package:mood_tracker/features/mood_entry/presentation/widgets/textfield.dart';

class AddNewEntry extends StatefulWidget {
  const AddNewEntry({super.key});

  @override
  State<AddNewEntry> createState() => _AddNewEntryState();
}

class _AddNewEntryState extends State<AddNewEntry> {
  final TextEditingController controller = TextEditingController();

  final Map<String, String> imagePath = {
    'ANGER': 'assets/imagesnoBg/anger.png',
    'JOY': 'assets/imagesnoBg/joy.png',
    'DISGUST': 'assets/imagesnoBg/disgust.png',
    'FEAR': 'assets/imagesnoBg/fear.png',
    'SAD': 'assets/imagesnoBg/sad.png',
    'EMBARASSMENT': 'assets/imagesnoBg/embarassment.png',
  };

  @override
  void initState() {
    context.read<MoodBloc>().add(PageChanged(moodName: "ANGER"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<MoodBloc, MoodState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
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
                      imagePath.entries.map((entry) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              child: Image.asset(
                                entry.value,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      print(imagePath.keys.elementAt(index));
                      context.read<MoodBloc>().add(
                        PageChanged(
                          moodName: imagePath.keys.elementAt(index).toString(),
                        ),
                      );

                      print(state);
                    },
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: DescriptionTF(descriptioncontroller: controller),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: ElevatedButton(
                  onPressed: () {
                    if (state is PageChangedState) {
                      context.read<MoodBloc>().add(
                        MoodAdded(
                          name: state.moodName,
                          date: DateTime.now(),
                          time: DateTime.now(),
                          description: controller.text,
                        ),
                      );
                    } else {
                      print(state);
                    }
                  },
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
            ],
          );
        },
      ),
    );
  }
}
