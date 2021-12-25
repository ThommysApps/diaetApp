import 'package:flutter/foundation.dart';

class Diaet {
  final String id;
  final String title;
  final String kcal;
  final String carbohydrates;
  final String startWeight;
  final String newWeight;
  final String maxKcal;
  final String difKcal;

  Diaet(
      {@required this.id,
      @required this.title,
      this.kcal,
      this.carbohydrates,
      this.startWeight,
      this.newWeight,
      this.maxKcal,
      this.difKcal});
}
