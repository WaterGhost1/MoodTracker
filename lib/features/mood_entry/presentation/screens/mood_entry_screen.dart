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
    'ANGER': 'assets/images2/anger.png',
    'JOY': 'assets/images2/joy.png',
    'DISGUST': 'assets/images2/disgust.png',
    'FEAR': 'assets/images2/fear.png',
    'SAD': 'assets/images2/sad.png',
    'EMBARASSMENT': 'assets/images2/embarassment.png',
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
            // mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'WHAT ARE YOU FEELING?',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 70), //70),
                child: CarouselSlider(
                  items:
                      imagePath.entries.map((entry) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: 230,
                              width: double.infinity,
                              child: Image.asset(
                                entry.value,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      context.read<MoodBloc>().add(
                        PageChanged(
                          moodName: imagePath.keys.elementAt(index).toString(),
                        ),
                      );

                      // print(state);
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
