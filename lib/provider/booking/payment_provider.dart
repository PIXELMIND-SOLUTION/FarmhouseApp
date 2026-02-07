import 'package:farmhouse_app/services/booking/payment_service.dart';
import 'package:flutter/material.dart';

enum PaymentStatus { idle, loading, success, error }

class PaymentProvider with ChangeNotifier {
  final PaymentService _service = PaymentService();

  PaymentStatus _status = PaymentStatus.idle;
  String _errorMessage = "";
  Map<String, dynamic>? _paymentResponse;

  PaymentStatus get status => _status;
  String get errorMessage => _errorMessage;
  Map<String, dynamic>? get paymentResponse => _paymentResponse;

  bool get isLoading => _status == PaymentStatus.loading;

  void _setStatus(PaymentStatus status, {String error = ""}) {
    _status = status;
    _errorMessage = error;
    notifyListeners();
  }

  /// Call this after Razorpay/payment gateway returns
  /// [verificationId] from your verify-slot response
  /// [transactionId] from Razorpay onSuccess callback
  /// [userId] from SharedPrefs
  Future<void> createPayment({
    required String verificationId,
    required String transactionId,
    required String userId,
  }) async {
    _setStatus(PaymentStatus.loading);

    try {
      _paymentResponse = await _service.createPayment(
        verificationId: verificationId,
        transactionId: transactionId,
        userId: userId,
      );

      print(
        'verificaaaaaaaaaaaaaaaaaaaaaaaaation idddddddddddddddd $verificationId',
      );
      print('transaction idddddddddddddddd $transactionId');
      print('userrrrrrrrrrrrrrrrrrrrrrrrr iddddddddddddddddd $userId');

      _setStatus(PaymentStatus.success);
    } catch (e) {
      _setStatus(PaymentStatus.error, error: e.toString());
    }
  }

  void reset() {
    _status = PaymentStatus.idle;
    _errorMessage = "";
    _paymentResponse = null;
    notifyListeners();
  }
}
