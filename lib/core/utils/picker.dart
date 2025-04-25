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
      case "EMBARASSMENT":
        return AppPallete.embarass;
      default:
        return AppPallete.joy;
    }
  }

  static String? imgPicker({required String name}) {
    final Map<String, String> imagePath = {
      'ANGER': 'assets/images2/anger.png',
      'JOY': 'assets/images2/joy.png',
      'DISGUST': 'assets/images2/disgust.png',
      'FEAR': 'assets/images2/fear.png',
      'SAD': 'assets/images2/sad.png',
      'EMBARASSMENT': 'assets/images2/embarassment.png',
    };
    return imagePath[name];
  }

  static String? lottiePicker({required String name}) {
    print("Pick name $name");
    final Map<String, String> imagePath = {
      'ANGER': 'assets/lottie/anger.json',
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
