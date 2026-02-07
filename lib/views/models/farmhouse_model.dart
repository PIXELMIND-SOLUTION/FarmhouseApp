
// class Location {
//   final String type;
//   final List<double> coordinates;

//   Location({
//     required this.type,
//     required this.coordinates,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       type: json['type'] ?? '',
//       coordinates: List<double>.from(json['coordinates'] ?? []),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'type': type,
//       'coordinates': coordinates,
//     };
//   }
// }

// class Farmhouse {
//   final String id;
//   final String name;
//   final List<String> images;
//   final String address;
//   final String description;
//   final List<String> amenities;
//   final String bookingFor;
//   final double pricePerHour;
//   final double pricePerDay;
//   final double rating;
//   final String feedbackSummary;
//   final Location location;
//   final List<String> wishlist;
//   final String createdAt;

//   Farmhouse({
//     required this.id,
//     required this.name,
//     required this.images,
//     required this.address,
//     required this.description,
//     required this.amenities,
//     required this.bookingFor,
//     required this.pricePerHour,
//     required this.pricePerDay,
//     required this.rating,
//     required this.feedbackSummary,
//     required this.location,
//     required this.wishlist,
//     required this.createdAt,
//   });

//   factory Farmhouse.fromJson(Map<String, dynamic> json) {
//     return Farmhouse(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       images: List<String>.from(json['images'] ?? []),
//       address: json['address'] ?? '',
//       description: json['description'] ?? '',
//       amenities: List<String>.from(json['amenities'] ?? []),
//       bookingFor: json['bookingFor'] ?? '',
//       pricePerHour: (json['pricePerHour'] ?? 0).toDouble(),
//       pricePerDay: (json['pricePerDay'] ?? 0).toDouble(),
//       rating: (json['rating'] ?? 0).toDouble(),
//       feedbackSummary: json['feedbackSummary'] ?? '',
//       location: Location.fromJson(json['location'] ?? {}),
//       wishlist: List<String>.from(json['wishlist'] ?? []),
//       createdAt: json['createdAt'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'images': images,
//       'address': address,
//       'description': description,
//       'amenities': amenities,
//       'bookingFor': bookingFor,
//       'pricePerHour': pricePerHour,
//       'pricePerDay': pricePerDay,
//       'rating': rating,
//       'feedbackSummary': feedbackSummary,
//       'location': location.toJson(),
//       'wishlist': wishlist,
//       'createdAt': createdAt,
//     };
//   }
// }

// class UserLocation {
//   final double lat;
//   final double lng;

//   UserLocation({
//     required this.lat,
//     required this.lng,
//   });

//   factory UserLocation.fromJson(Map<String, dynamic> json) {
//     return UserLocation(
//       lat: (json['lat'] ?? 0).toDouble(),
//       lng: (json['lng'] ?? 0).toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'lat': lat,
//       'lng': lng,
//     };
//   }
// }

// class NearbyFarmhouseResponse {
//   final bool success;
//   final UserLocation userLocation;
//   final int count;
//   final List<Farmhouse> farmhouses;

//   NearbyFarmhouseResponse({
//     required this.success,
//     required this.userLocation,
//     required this.count,
//     required this.farmhouses,
//   });

//   factory NearbyFarmhouseResponse.fromJson(Map<String, dynamic> json) {
//     return NearbyFarmhouseResponse(
//       success: json['success'] ?? false,
//       userLocation: UserLocation.fromJson(json['userLocation'] ?? {}),
//       count: json['count'] ?? 0,
//       farmhouses: (json['farmhouses'] as List?)
//               ?.map((e) => Farmhouse.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'success': success,
//       'userLocation': userLocation.toJson(),
//       'count': count,
//       'farmhouses': farmhouses.map((e) => e.toJson()).toList(),
//     };
//   }
// }



















class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: List<double>.from(json['coordinates'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

class TimePrice {
  final String id;
  final String label;
  final String timing;
  final double price;

  TimePrice({
    required this.id,
    required this.label,
    required this.timing,
    required this.price,
  });

  factory TimePrice.fromJson(Map<String, dynamic> json) {
    return TimePrice(
      id: json['_id'] ?? '',
      label: json['label'] ?? '',
      timing: json['timing'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'label': label,
      'timing': timing,
      'price': price,
    };
  }
}

class Review {
  final String id;
  final String name;
  final int rating;
  final String comment;
  final String date;

  Review({
    required this.id,
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'rating': rating,
      'comment': comment,
      'date': date,
    };
  }
}

class Farmhouse {
  final String id;
  final String name;
  final List<String> images;
  final String address;
  final String description;
  final List<String> amenities;
  final String bookingFor;
  final double pricePerHour;
  final double pricePerDay;
  final List<TimePrice> timePrices;
  final double rating;
  final String feedbackSummary;
  final Location location;
  final List<String> wishlist;
  final List<Review> reviews;
  final List<dynamic> bookedSlots;
  final String createdAt;

  Farmhouse({
    required this.id,
    required this.name,
    required this.images,
    required this.address,
    required this.description,
    required this.amenities,
    required this.bookingFor,
    required this.pricePerHour,
    required this.pricePerDay,
    required this.timePrices,
    required this.rating,
    required this.feedbackSummary,
    required this.location,
    required this.wishlist,
    required this.reviews,
    required this.bookedSlots,
    required this.createdAt,
  });

  factory Farmhouse.fromJson(Map<String, dynamic> json) {
    return Farmhouse(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      amenities: List<String>.from(json['amenities'] ?? []),
      bookingFor: json['bookingFor'] ?? '',
      pricePerHour: (json['pricePerHour'] ?? 0).toDouble(),
      pricePerDay: (json['pricePerDay'] ?? 0).toDouble(),
      timePrices: (json['timePrices'] as List?)
              ?.map((e) => TimePrice.fromJson(e))
              .toList() ??
          [],
      rating: (json['rating'] ?? 0).toDouble(),
      feedbackSummary: json['feedbackSummary'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      wishlist: List<String>.from(json['wishlist'] ?? []),
      reviews: (json['reviews'] as List?)
              ?.map((e) => Review.fromJson(e))
              .toList() ??
          [],
      bookedSlots: List<dynamic>.from(json['bookedSlots'] ?? []),
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'images': images,
      'address': address,
      'description': description,
      'amenities': amenities,
      'bookingFor': bookingFor,
      'pricePerHour': pricePerHour,
      'pricePerDay': pricePerDay,
      'timePrices': timePrices.map((e) => e.toJson()).toList(),
      'rating': rating,
      'feedbackSummary': feedbackSummary,
      'location': location.toJson(),
      'wishlist': wishlist,
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'bookedSlots': bookedSlots,
      'createdAt': createdAt,
    };
  }
}

class UserLocation {
  final double lat;
  final double lng;

  UserLocation({
    required this.lat,
    required this.lng,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class NearbyFarmhouseResponse {
  final bool success;
  final UserLocation userLocation;
  final int count;
  final List<Farmhouse> farmhouses;

  NearbyFarmhouseResponse({
    required this.success,
    required this.userLocation,
    required this.count,
    required this.farmhouses,
  });

  factory NearbyFarmhouseResponse.fromJson(Map<String, dynamic> json) {
    return NearbyFarmhouseResponse(
      success: json['success'] ?? false,
      userLocation: UserLocation.fromJson(json['userLocation'] ?? {}),
      count: json['count'] ?? 0,
      farmhouses: (json['farmhouses'] as List?)
              ?.map((e) => Farmhouse.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'userLocation': userLocation.toJson(),
      'count': count,
      'farmhouses': farmhouses.map((e) => e.toJson()).toList(),
    };
  }
}