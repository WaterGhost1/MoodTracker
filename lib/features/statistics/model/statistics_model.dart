class StatisticsModel {
  final double joyCount;
  final double angerCount;
  final double sadCount;
  final double fearCount;
  final double disgustCount;
  final double embarassedCount;
  final double totalCount;
  final Map<String, double> highest;
  final Map<String, double> lowest;

  StatisticsModel._internal({
    required this.totalCount,
    required this.joyCount,
    required this.angerCount,
    required this.sadCount,
    required this.fearCount,
    required this.disgustCount,
    required this.embarassedCount,
    required this.highest,
    required this.lowest,
  });

  factory StatisticsModel({
    required double joyCount,
    required double angerCount,
    required double sadCount,
    required double fearCount,
    required double disgustCount,
    required double embarassedCount,
  }) {
    Map<String, double> moodValues = {
      "JOY": joyCount,
      "ANGER": angerCount,
      "SAD": sadCount,
      "FEAR": fearCount,
      "DISGUST": disgustCount,
      "EMBARASSED": embarassedCount,
    };

    String highestMood =
        moodValues.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    double highestValue = moodValues[highestMood]!;

    String lowestMood =
        moodValues.entries.reduce((a, b) => a.value < b.value ? a : b).key;
    double lowestValue = moodValues[lowestMood]!;

    double totalCount = moodValues.values.reduce((a, b) => a + b);

    return StatisticsModel._internal(
      totalCount: totalCount,
      joyCount: joyCount,
      angerCount: angerCount,
      sadCount: sadCount,
      fearCount: fearCount,
      disgustCount: disgustCount,
      embarassedCount: embarassedCount,
      highest: {highestMood: highestValue},
      lowest: {lowestMood: lowestValue},
    );
  }
}
