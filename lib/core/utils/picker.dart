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
}
