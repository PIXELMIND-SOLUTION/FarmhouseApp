// import 'package:flutter/material.dart';

// class WishlistManager extends ChangeNotifier {
//   static final WishlistManager _instance = WishlistManager._internal();
//   factory WishlistManager() => _instance;
//   WishlistManager._internal();

//   final List<Map<String, dynamic>> _wishlistItems = [];

//   List<Map<String, dynamic>> get wishlistItems => _wishlistItems;

//   bool isInWishlist(String title) {
//     return _wishlistItems.any((item) => item['title'] == title);
//   }

//   void addToWishlist(Map<String, dynamic> item) {
//     if (!isInWishlist(item['title'])) {
//       _wishlistItems.add(item);
//       notifyListeners();
//     }
//   }

//   void removeFromWishlist(String title) {
//     _wishlistItems.removeWhere((item) => item['title'] == title);
//     notifyListeners();
//   }

//   void toggleWishlist(Map<String, dynamic> item) {
//     if (isInWishlist(item['title'])) {
//       removeFromWishlist(item['title']);
//     } else {
//       addToWishlist(item);
//     }
//   }
// }
















import 'package:flutter/material.dart';

class WishlistManager extends ChangeNotifier {
  static final WishlistManager _instance = WishlistManager._internal();
  factory WishlistManager() => _instance;
  WishlistManager._internal();

  final List<Map<String, dynamic>> _wishlistItems = [];

  List<Map<String, dynamic>> get wishlistItems => _wishlistItems;

  bool isInWishlist(String name) {
    return _wishlistItems.any((item) => item['name'] == name);
  }

  void addToWishlist(Map<String, dynamic> item) {
    if (!isInWishlist(item['name'])) {
      _wishlistItems.add(item);
      notifyListeners();
    }
  }

  void removeFromWishlist(String name) {
    _wishlistItems.removeWhere((item) => item['name'] == name);
    notifyListeners();
  }

  void toggleWishlist(Map<String, dynamic> item) {
    if (isInWishlist(item['name'])) {
      removeFromWishlist(item['name']);
    } else {
      addToWishlist(item);
    }
  }
}