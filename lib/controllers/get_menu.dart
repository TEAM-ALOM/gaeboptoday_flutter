import 'package:dio/dio.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';

Future<List<Food>> getAllFoodData() async {
  List<Food> resultValue = [];
  Dio dio = Dio();
  try {
    final response = await dio.get(
      'http://52.79.88.147:3000/api/menu',
      onReceiveProgress: (int sent, int total) {
        print('$sent $total');
      },
    );
    for (var data in response.data['data']) {
      print(data['name']);
      resultValue.add(Food.img(
        data['name'].toString(),
        double.tryParse(data['rating'].toString())!,
        data['imagePath'].toString() == 'null'
            ? 'assets/images/defaultImg.png'
            : data['imagePath'].toString(),
      ));
    }
    return resultValue;
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
  }
  return [
    Food.nodata(),
    Food.nodata(),
    Food.nodata(),
    Food.nodata(),
    Food.nodata()
  ];
}
