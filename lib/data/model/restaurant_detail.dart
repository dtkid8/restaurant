class RestaurantDetail {
  late bool error;
  late String message;
  late Detail? restaurant;

  RestaurantDetail({required this.error, required this.message, required this.restaurant});

  RestaurantDetail.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    restaurant = json['restaurant'] != null ? new Detail.fromJson(json['restaurant']) : null;
  }
}

class Detail {
  late String id;
  late String name;
  late String description;
  late String city;
  late String address;
  late String pictureId;
  late List<Categories> categories;
  late Menus? menus;
  late double rating;
  late List<CustomerReviews> customerReviews;
  late bool isFavorite; 
  

  Detail(
      {
      required this.categories,
      required this.menus,
      required this.rating,
      required this.customerReviews, 
      this.isFavorite = false,
      });

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    city = json['city'];
    address = json['address'];
    pictureId = json['pictureId'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    menus = json['menus'] != null ? new Menus.fromJson(json['menus']) : null;
    rating = json['rating'].toDouble();
    if (json['customerReviews'] != null) {
      customerReviews = <CustomerReviews>[];
      json['customerReviews'].forEach((v) {
        customerReviews.add(new CustomerReviews.fromJson(v));
      });
    }
    isFavorite = false;
  }
}

class Categories {
  late String name;

  Categories({required this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Menus {
  late List<Foods> foods;
  late List<Drinks> drinks;

  Menus({required this.foods, required this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods.add(new Foods.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = <Drinks>[];
      json['drinks'].forEach((v) {
        drinks.add(new Drinks.fromJson(v));
      });
    }
  }
}

class Foods {
  late String name;
  Foods({required this.name});
  Foods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class Drinks {
  late String name;
  Drinks({required this.name});
  Drinks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class CustomerReviews {
  late String name;
  late String review;
  late String date;

  CustomerReviews({required this.name, required this.review, required this.date});

  CustomerReviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    review = json['review'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['review'] = this.review;
    data['date'] = this.date;
    return data;
  }
}
