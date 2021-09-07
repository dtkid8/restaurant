class Restaurant {
  late List<Restaurants> restaurants;

  Restaurant({required this.restaurants});

  Restaurant.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = <Restaurants>[];
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurants {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;

  Restaurants({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'].toDouble();
  }

// Restaurants.fromMap(Map<String, dynamic> map) {
//     id = map['id'];
//     description = map['description'];
//     pictureId = map['picture_id'];
//     city = map['city'];
//     rating = map['rating'];
//   }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'description': description,
  //     'picture_id' : pictureId,
  //     'city': city,
  //     'rating': rating,
  //   };
  // }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
