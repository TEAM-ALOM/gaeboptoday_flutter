import 'dart:ui';

class Review {
  int writer = 0;
  double rate = 0;
  String review = "";
}

class Food {
  Image? image;
  String name = "";
  double rate = 0;
  List<Review> foodReview = [];
  bool isFavorite = false;
}

class Menu {
  List<Food> menuList = [];
  double menuRate = 0.0;

  dataInput(List<Food> value, double rate) {
    menuList = value;
    menuRate = rate;
  }

  clear() {
    menuList = [];
    menuRate = 0.0;
  }

  bool isEmpty() {
    return menuList.isEmpty;
  }

  bool isNotEmpty() {
    return menuList.isNotEmpty;
  }

  int length() {
    return menuList.length;
  }
}

class MenuModel {
  Menu lunch = Menu(), dinner = Menu();
  DateTime? date;
  //default constructor
  MenuModel();
  //named constructor
  MenuModel.init(int month, int day) {
    date = DateTime(2024, month, day);
  }
}
