import 'package:gaeboptoday_flutter/models/menu_model.dart';

MenuModel menuJsonToStringList({
  required Map<String, dynamic> jsonData,
  required bool isReaderRequest,
}) {
  //getting ready for data
  List<int> dates = isReaderRequest ? [0, 1, 2, 3, 4] : [0];
  MenuModel decodeResult = MenuModel();
  print(dates);
  try {
    dynamic contentMap = isReaderRequest
        ? jsonData['data']['result']['content']
        : jsonData['data'];
//jsonData['data']['content'][0]['lunch']
    Menu tempLunch = Menu(), tempDinner = Menu();
    Food foodTemp;
    for (var date in dates) {
      tempLunch.clear();

      for (var data in contentMap[date]['content'][0]['lunch']) {
        foodTemp = Food.init(data['name'], data['rating'], data['reviews']);
        tempLunch.add(foodTemp);
      }

      //CALL BY REFERENSE & CALL BY VALUE
      decodeResult.lunch = tempLunch;

      tempDinner.clear();
      for (var data in contentMap[date]['content'][0]['dinner']) {
        foodTemp = Food.init(data['name'], data['rating'], data['reviews']);
        tempDinner.add(foodTemp);
      }
      decodeResult.dinner = tempDinner;
    }
    return decodeResult;
  } catch (e) {
    // print(e);
    return decodeResult;
  }
}
