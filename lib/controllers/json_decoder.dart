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
    dynamic contentMap =
        isReaderRequest ? jsonData['data']['result']['content'] : null;
//jsonData['data']['content'][0]['lunch']
    Menu temp = Menu();
    for (var date in dates) {
      temp.clear();
      // decodeResultList.add({});
      for (var data in isReaderRequest
          ? contentMap[date]['content'][0]['lunch']
          : jsonData['data']['content'][0]['lunch']) {
        temp.menuList.add(data['name']);
      }

      //CALL BY REFERENSE & CALL BY VALUE
      decodeResult.lunch = temp;

      temp.clear();
      for (var data in isReaderRequest
          ? contentMap[date]['content'][0]['dinner']
          : jsonData['data']['content'][0]['dinner']) {
        temp.menuList.add(data['name']);
      }
      decodeResult.dinner = temp;
    }
    // print(decodeResultList);
    return decodeResult;
  } catch (e) {
    return decodeResult;
  }
}
