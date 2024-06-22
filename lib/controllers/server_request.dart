import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gaeboptoday_flutter/controllers/json_decoder.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';

Future<MenuModel> getMenuData(int month, int day) async {
  Dio dio = Dio();
  MenuModel menuData = MenuModel.init(month, day);
  try {
    final response = await dio.post(
      'http://52.79.88.147:3000/api/data',
      // data: formData,
      data: json.encode({
        'month': month,
        'day': day,
        'type': 0,
      }),
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );
    // print(response.data);
    menuData =
        menuJsonToStringList(jsonData: response.data, isReaderRequest: false);
    return menuData;
  } on DioException catch (e) {
    if (e.response != null) {
      print(e.response!.data);
      print(e.response!.headers);
      print(e.response!.requestOptions);
    } else {
      print(e.requestOptions);
      print(e.message);
    }
    print(e.error);
    return menuData;
  }
}
