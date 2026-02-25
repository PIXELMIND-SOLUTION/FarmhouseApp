class ApiConstants {
  static const String baseUrl = "http://31.97.206.144:5124/api";
  static const String register = "$baseUrl/auth/register";
  static const String login = "$baseUrl/auth/login";
  static const String forgotpassword = "$baseUrl/auth/forgot-password";
  static const String resetpassword = "$baseUrl/auth/reset-password";
  static const String verifyOtp = '$baseUrl/auth/verify-otp';
  static const String getProfile = '$baseUrl/auth/getprofile/userId';
  static const String updateProfile = '$baseUrl/auth/userId/update';
  static const String livelocation = '$baseUrl/auth/userId/live-location';
  static const String updateAddress = '$baseUrl/auth/userId/update-address';
  static const String nearbyfarmhouse = '$baseUrl/nearby/user/userId';
  static const String bookfarmhouse = '$baseUrl/order/verify-slot';

  static const String addtowishlist = '$baseUrl/farmhouseId/wishlist/userId';
  static const String getwishlist = '$baseUrl/get-wishlist/userId';
  static const String payment = '$baseUrl/order/create';
  static const String guestlogin='$baseUrl/auth/guestlogin';
}
