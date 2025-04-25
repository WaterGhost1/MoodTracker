import 'dart:ui';

import 'package:mood_tracker/core/theme/app_pallete.dart';

class Picker {
  static Color colorPicker({required String name}) {
    switch (name) {
      case "JOY":
        return AppPallete.joy;
      case "ANGER":
        return AppPallete.anger;
      case "FEAR":
        return AppPallete.fear;
      case "DISGUST":
        return AppPallete.disgust;
      case "SAD":
        return AppPallete.sad;
      case "EMBARASS":
        return AppPallete.embarass;
      default:
        return AppPallete.joy;
    }
  }

  static String? imgPicker({required String name}) {
    final Map<String, String> imagePath = {
      'ANGER': 'assets/imagesnoBg/anger.png',
      'JOY': 'assets/imagesnoBg/joy.png',
      'DISGUST': 'assets/imagesnoBg/disgust.png',
      'FEAR': 'assets/imagesnoBg/fear.png',
      'SAD': 'assets/imagesnoBg/sad.png',
      'EMBARASSMENT': 'assets/imagesnoBg/embarassment.png',
    };
    return imagePath[name];
  }

  static String? lottiePicker({required String name}) {
    print("Pick name $name");
    final Map<String, String> imagePath = {
      'ANGER': 'assets/lottie/anger.png',
      'JOY': 'assets/lottie/happy.json',
      'DISGUST': 'assets/lottie/disgusted.json',
      'FEAR': 'assets/lottie/fear.json',
      'SAD': 'assets/lottie/sad.json',
      'EMBARASSMENT': 'assets/lottie/embarassed.json',
    };
    print("image path ${imagePath[name]}");
    return imagePath[name] ?? 'assets/lottie/nodata.json';
  }
}
