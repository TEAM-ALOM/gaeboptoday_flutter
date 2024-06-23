// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:gaeboptoday_flutter/controllers/json_decoder.dart';
// import 'package:gaeboptoday_flutter/models/menu_model.dart';

// void loginRequest(String id, String password) async {
//   Dio dio = Dio();
//   try {
//     final response = await dio.post(
//       'http://52.79.88.147:3000/api/auth/login',
//       // data: formData,
//       data: json.encode({
//         'id': id,
//         'password': password,
//       }),
//       onSendProgress: (int sent, int total) {
//         print('$sent $total');  
//       },
//     );
//     // print(response.data);
//     menuData =
//         menuJsonToStringList(jsonData: response.data, isReaderRequest: false);
//     return menuData;
//   } on DioException catch (e) {
//     if (e.response != null) {
//       print(e.response!.data);
//       print(e.response!.headers);
//       print(e.response!.requestOptions);
//     } else {
//       print(e.requestOptions);
//       print(e.message);
//     }
//     print(e.error);
//     return menuData;
//   }
// }
