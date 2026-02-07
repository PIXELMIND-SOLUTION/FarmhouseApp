// wishlist_provider.dart

import 'package:farmhouse_app/model/wishlist_model.dart';
import 'package:farmhouse_app/services/wishlist/wishlist_services.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistService _service = WishlistService();

  List<FarmhouseModel> _wishlist = [];
  bool _isLoading = false;
  String? _errorMessage;

  // --------------- Getters ---------------
  List<FarmhouseModel> get wishlist => _wishlist;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --------------- Fetch Wishlist ---------------
  /// Loads the wishlist from the server using the saved userId
  Future<void> fetchWishlist() async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final user = await SharedPrefs.getUser();
      if (user == null) {
        _errorMessage = "User not logged in.";
        _setLoading(false);
        return;
      }

      final response = await _service.getWishlist(user.id);
      _wishlist = response.data;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // --------------- Toggle Wishlist ---------------
  /// Adds or removes a farmhouse from wishlist.
  /// Uses optimistic UI update — updates locally first, reverts on failure.
  Future<void> toggleWishlist(String farmhouseId) async {
    final user = await SharedPrefs.getUser();
    if (user == null) {
      _errorMessage = "User not logged in.";
      notifyListeners();
      return;
    }

    // --- Optimistic update ---
    final int existingIndex = _wishlist.indexWhere((f) => f.id == farmhouseId);
    final bool isCurrentlyWishlisted = existingIndex != -1;
    FarmhouseModel? removedItem;

    if (isCurrentlyWishlisted) {
      // Remove locally
      removedItem = _wishlist[existingIndex];
      _wishlist.removeAt(existingIndex);
    }
    // Note: if adding, we don't have the full object locally yet,
    // so we refetch after a successful toggle.

    notifyListeners();

    try {
      final response = await _service.toggleWishlist(
        farmhouseId: farmhouseId,
        userId: user.id,
      );

      if (response.success) {
        if (!isCurrentlyWishlisted) {
          // Was an "add" — refetch to get the full farmhouse object
          await fetchWishlist();
        }
        // If it was a "remove", optimistic update is already correct
      } else {
        // Revert optimistic update on unexpected response
        _revert(removedItem, existingIndex);
      }
    } catch (e) {
      // Revert optimistic update on error
      _revert(removedItem, existingIndex);
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // --------------- Check if wishlisted ---------------
  /// Returns true if the farmhouse is already in the local wishlist
  bool isWishlisted(String farmhouseId) {
    return _wishlist.any((f) => f.id == farmhouseId);
  }

  // --------------- Private Helpers ---------------
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Re-inserts a removed item back at its original index (used on failure)
  void _revert(FarmhouseModel? item, int index) {
    if (item != null) {
      _wishlist.insert(index, item);
    }
  }
}