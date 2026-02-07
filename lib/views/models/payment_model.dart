class SlotDetails {
  final String label;
  final String timing;
  final double price;
  final DateTime checkIn;
  final DateTime checkOut;

  const SlotDetails({
    required this.label,
    required this.timing,
    required this.price,
    required this.checkIn,
    required this.checkOut,
  });

  factory SlotDetails.fromJson(Map<String, dynamic> json) {
    return SlotDetails(
      label: json['label'] as String,
      timing: json['timing'] as String,
      price: (json['price'] as num).toDouble(),
      checkIn: DateTime.parse(json['checkIn'] as String),
      checkOut: DateTime.parse(json['checkOut'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'timing': timing,
        'price': price,
        'checkIn': checkIn.toIso8601String(),
        'checkOut': checkOut.toIso8601String(),
      };
}

class PriceBreakdown {
  final double slotPrice;
  final double cleaningFee;
  final double serviceFee;
  final double totalAmount;

  const PriceBreakdown({
    required this.slotPrice,
    required this.cleaningFee,
    required this.serviceFee,
    required this.totalAmount,
  });

  factory PriceBreakdown.fromJson(Map<String, dynamic> json) {
    return PriceBreakdown(
      slotPrice: (json['slotPrice'] as num).toDouble(),
      cleaningFee: (json['cleaningFee'] as num).toDouble(),
      serviceFee: (json['serviceFee'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'slotPrice': slotPrice,
        'cleaningFee': cleaningFee,
        'serviceFee': serviceFee,
        'totalAmount': totalAmount,
      };
}

class FarmhouseInfo {
  final String name;
  final String address;
  final List<String> images;

  const FarmhouseInfo({
    required this.name,
    required this.address,
    required this.images,
  });

  factory FarmhouseInfo.fromJson(Map<String, dynamic> json) {
    return FarmhouseInfo(
      name: json['name'] as String,
      address: json['address'] as String,
      images: List<String>.from(json['images'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'images': images,
      };
}

/// Response model for POST /order/verify-slot
class BookingVerificationResponse {
  final bool success;
  final bool available;
  final String verificationId;
  final DateTime expiresAt;
  final SlotDetails slotDetails;
  final PriceBreakdown priceBreakdown;
  final FarmhouseInfo farmhouse;
  final String message;

  const BookingVerificationResponse({
    required this.success,
    required this.available,
    required this.verificationId,
    required this.expiresAt,
    required this.slotDetails,
    required this.priceBreakdown,
    required this.farmhouse,
    required this.message,
  });

  factory BookingVerificationResponse.fromJson(Map<String, dynamic> json) {
    return BookingVerificationResponse(
      success: json['success'] as bool,
      available: json['available'] as bool,
      verificationId: json['verificationId'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      slotDetails: SlotDetails.fromJson(json['slotDetails'] as Map<String, dynamic>),
      priceBreakdown: PriceBreakdown.fromJson(json['priceBreakdown'] as Map<String, dynamic>),
      farmhouse: FarmhouseInfo.fromJson(json['farmhouse'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }

  /// Time remaining (in seconds) before the verificationId expires.
  /// Returns 0 if already expired.
  int get remainingSecondsToExpiry {
    final diff = expiresAt.difference(DateTime.now().toUtc()).inSeconds;
    return diff > 0 ? diff : 0;
  }

  bool get isExpired => remainingSecondsToExpiry <= 0;
}

// ============================================================
// 📁 lib/models/payment_model.dart
// ============================================================

/// Payload sent to POST /order/create
class PaymentRequest {
  final String verificationId;
  final String transactionId;

  const PaymentRequest({
    required this.verificationId,
    required this.transactionId,
  });

  Map<String, dynamic> toJson() => {
        'verificationId': verificationId,
        'transactionId': transactionId,
      };
}

/// Response model for POST /order/create
/// Adjust fields below once you have the actual response body from the server.
class PaymentResponse {
  final bool success;
  final String? orderId;
  final String? message;
  final Map<String, dynamic>? rawData; // keep full raw map as fallback

  const PaymentResponse({
    required this.success,
    this.orderId,
    this.message,
    this.rawData,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      success: json['success'] as bool? ?? false,
      orderId: json['orderId'] as String?,
      message: json['message'] as String?,
      rawData: json,
    );
  }
}