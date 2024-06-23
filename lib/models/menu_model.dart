class Review {
  String writer = "";
  double rate = 0;
  String review = "";
  DateTime? dateTime;
  Review();
  // Review.init(this.writer, this.rate, this.review);
  Review.init(
    this.writer,
    this.rate,
    this.review,
    this.dateTime,
  );
}

class Food {
  String imagePath = 'assets/images/defaultImg.png';
  String name = "";
  double rate = 0;
  List<Review> foodReview = [];
  bool isFavorite = false;

  void addReview(Review value) {
    foodReview.add(value);
  }

  Food();
  Food.nodata() {
    name = "NO DATA";
  }
  Food.init(
    name,
    rate,
    // foodReview,
  ) {
    this.name = name.toString();
    // this.rate = double.tryParse(rate.toString()) ?? 0;
    // try {
    //   for (var data in foodReview) {
    //     this.foodReview.add(Review.init(data['nickname'].toString(),
    //         double.tryParse(data['rate'].toString()) ?? 0, data['substance']));
    //   }
    // } catch (e) {
    //   print(e);
    // } finally {
    //   this.foodReview = [];
    // }
  }
  Food.img(this.name, this.rate, this.imagePath);
}

class Menu {
  List<Food> menuList = [];
  double menuRate = 0.0;
  add(Food data) {
    double calculateRate = 0;
    menuList.add(data);
    for (var menu in menuList) {
      calculateRate += menu.rate;
    }
    menuRate = calculateRate / menuList.length;
  }

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
