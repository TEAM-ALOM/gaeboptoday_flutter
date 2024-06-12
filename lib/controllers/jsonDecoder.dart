List<Map<String, List<String>>> menuJsonToStringList({
  required Map<String, dynamic> jsonData,
  required bool isReaderRequest,
}) {
  //getting ready for data
  List<int> dates = isReaderRequest ? [0, 1, 2, 3, 4] : [0];

  print(dates);
  try {
    dynamic contentMap =
        isReaderRequest ? jsonData['data']['result']['content'] : null;
//jsonData['data']['content'][0]['lunch']
    List<Map<String, List<String>>> decodeResultList = [];
    List<String> temp = [];
    for (var date in dates) {
      temp.clear();
      decodeResultList.add({});
      for (var data in isReaderRequest
          ? contentMap[date]['content'][0]['lunch']
          : jsonData['data']['content'][0]['lunch']) {
        temp.add(data['name']);
      }
      //CALL BY REFERENSE & CALL BY VALUE
      decodeResultList[date]['lunch'] = List.of(temp);
      temp.clear();
      for (var data in isReaderRequest
          ? contentMap[date]['content'][0]['dinner']
          : jsonData['data']['content'][0]['dinner']) {
        temp.add(data['name']);
      }
      decodeResultList[date]['dinner'] = List.of(temp);
    }
    // print(decodeResultList);
    return decodeResultList;
  } catch (e) {
    return [
      {'lunch': [], 'dinner': []}
    ];
  }
}
