import 'package:diaetapp/helpers/db_helper.dart';
import 'package:diaetapp/models/diaet.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class GreatDiaet with ChangeNotifier {
  //To set Creation Time
  static DateTime actualTime = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(actualTime);

  List<Diaet> _items = [];

  List<Diaet> get items {
    return [..._items];
  }

  //Information des gesamten places
  Diaet findById(String id) {
    return items.firstWhere((diaet) => diaet.id == id);
  }

  Future<void> addDiaet(
    String pickedTitle,
    String pickedCarbohydrate,
    String pickedkcal,
    String pickedStartWeight,
    String pickedNewWeight,
    String pickedMaxKcal,
    String pickedDifKcal,
  ) async {
    final newDay = Diaet(
      id: DateTime.now().toString(),
      title: pickedTitle,
      carbohydrates: pickedCarbohydrate,
      kcal: pickedkcal,
      startWeight: pickedStartWeight,
      newWeight: pickedNewWeight,
      maxKcal: pickedMaxKcal,
      difKcal: pickedDifKcal,
    );
    _items.add(newDay);
    notifyListeners();
    //übergabe 'wanderwege' so wie in db_helper definiert , Data ist von typ map
    DBHelper.insert('diaet_log', {
      'id': newDay.id,
      'title': newDay.title,
      'carbohydrates': newDay.carbohydrates,
      'kcal': newDay.kcal,
      'startWeight': newDay.startWeight,
      'newWeight': newDay.newWeight,
      'maxKcal': newDay.maxKcal,
      'difKcal': newDay.difKcal,
    });
  }

  //Die ganzen places aus der DB holen
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('diaet_log');
    _items = dataList
        .map((item) => Diaet(
              id: item['id'],
              title: item['title'],
              carbohydrates: item['carbohydrates'],
              kcal: item['kcal'],
              startWeight: item['startWeight'],
              newWeight: item['newWeight'],
              maxKcal: item['maxKcal'],
              difKcal: item['difKcal'],
            ))
        .toList();
    notifyListeners();
  }
}
