import 'package:dio/dio.dart';
import 'package:gaeboptoday_flutter/models/menu_model.dart';

Future<List<Review>> getFoodReviewData(Food value) async {
  Dio dio = Dio();
  try {
    final response = await dio.get(
      'http://52.79.88.147:3000/api/review/${value.name}',
      onReceiveProgress: (int sent, int total) {
        print('$sent $total');
      },
    );
    for (var data in response.data['data']) {
      value.addReview(
        Review.init(
          data['nickname'].toString(),
          double.tryParse(data['rate'].toString()) ?? 0,
          data['substance'].toString(),
          DateTime(
            2024,
            int.tryParse(data['month'].toString()) ?? 0,
            int.tryParse(data['day'].toString()) ?? 0,
          ),
        ),
      );
    }
    return value.foodReview;
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
  return value.foodReview;
}
