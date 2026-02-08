class Validators {
  /// Phone Validator
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    // Remove any non-digit characters for validation
    final digitsOnly = value.trim().replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length != 10) {
      return "Enter a valid 10-digit phone number";
    }

    // Check if phone starts with valid Indian mobile prefix (6-9)
    if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(digitsOnly)) {
      return "Phone number must start with 6, 7, 8, or 9";
    }

    return null;
  }

  /// Strong Password Validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    if (value.length > 32) {
      return "Password must not exceed 32 characters";
    }

    // Must contain at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter";
    }

    // Must contain at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least one lowercase letter";
    }

    // Must contain at least one digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number";
    }

    // Must contain at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Password must contain at least one special character";
    }

    // No whitespace allowed
    if (RegExp(r'\s').hasMatch(value)) {
      return "Password cannot contain spaces";
    }

    return null;
  }

  /// Email Validator
static String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Email is required";
  }

  final email = value.trim().toLowerCase();

  // Basic format check
  final basicRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  if (!basicRegex.hasMatch(email)) {
    return "Enter a valid email address";
  }

  // No consecutive dots
  if (email.contains('..')) {
    return "Email cannot contain consecutive dots";
  }

  // Allow only gmail or yahoo
  if (!(email.contains('@gmail.') || email.contains('@yahoo.'))) {
    return "Only Gmail or Yahoo emails allowed";
  }

  // Allow only .com or .in
  if (!(email.endsWith('.com') || email.endsWith('.in'))) {
    return "Only .com or .in domains allowed";
  }

  return null;
}


  /// Name Validator (First/Last Name)
  static String? validateName(String? value, {String fieldName = "Name"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 2) {
      return "$fieldName must be at least 2 characters";
    }

    if (trimmedValue.length > 50) {
      return "$fieldName must not exceed 50 characters";
    }

    // Allow letters, spaces, hyphens, and apostrophes
    if (!RegExp(r"^[a-zA-Z]+([ \-'][a-zA-Z]+)*$").hasMatch(trimmedValue)) {
      return "$fieldName can only contain letters, spaces, hyphens, and apostrophes";
    }

    // Must start and end with a letter
    if (!RegExp(r'^[a-zA-Z].*[a-zA-Z]$|^[a-zA-Z]$').hasMatch(trimmedValue)) {
      return "$fieldName must start and end with a letter";
    }

    return null;
  }

  /// Confirm Password Validator
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }

    if (value != password) {
      return "Passwords do not match";
    }

    return null;
  }

  /// OTP Validator
  static String? validateOTP(String? value, {int length = 6}) {
    if (value == null || value.trim().isEmpty) {
      return "OTP is required";
    }

    final digitsOnly = value.trim().replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length != length) {
      return "Enter a valid $length-digit OTP";
    }

    return null;
  }

  /// Username Validator
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }

    final username = value.trim();

    if (username.length < 3) {
      return "Username must be at least 3 characters";
    }

    if (username.length > 20) {
      return "Username must not exceed 20 characters";
    }

    // Only alphanumeric, underscore, and dot allowed
    if (!RegExp(r'^[a-zA-Z0-9._]+$').hasMatch(username)) {
      return "Username can only contain letters, numbers, dots, and underscores";
    }

    // Must start with a letter
    if (!RegExp(r'^[a-zA-Z]').hasMatch(username)) {
      return "Username must start with a letter";
    }

    // Cannot end with dot or underscore
    if (RegExp(r'[._]$').hasMatch(username)) {
      return "Username cannot end with dot or underscore";
    }

    return null;
  }

  /// Age Validator (for date of birth)
  static String? validateAge(DateTime? dateOfBirth, {int minAge = 18, int maxAge = 120}) {
    if (dateOfBirth == null) {
      return "Date of birth is required";
    }

    final today = DateTime.now();
    final age = today.year - dateOfBirth.year -
        ((today.month > dateOfBirth.month ||
                (today.month == dateOfBirth.month && today.day >= dateOfBirth.day))
            ? 0
            : 1);

    if (age < minAge) {
      return "You must be at least $minAge years old";
    }

    if (age > maxAge) {
      return "Please enter a valid date of birth";
    }

    if (dateOfBirth.isAfter(today)) {
      return "Date of birth cannot be in the future";
    }

    return null;
  }

  /// Address Validator
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Address is required";
    }

    final address = value.trim();

    if (address.length < 10) {
      return "Address must be at least 10 characters";
    }

    if (address.length > 200) {
      return "Address must not exceed 200 characters";
    }

    return null;
  }

  /// Pincode/Zipcode Validator (Indian format)
  static String? validatePincode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Pincode is required";
    }

    final digitsOnly = value.trim().replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length != 6) {
      return "Enter a valid 6-digit pincode";
    }

    // Indian pincodes don't start with 0
    if (digitsOnly.startsWith('0')) {
      return "Invalid pincode format";
    }

    return null;
  }

  /// Generic Required Field Validator
  static String? validateRequired(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  /// URL Validator
  static String? validateURL(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "URL is required";
    }

    final url = value.trim();

    if (!RegExp(
            r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$')
        .hasMatch(url)) {
      return "Enter a valid URL";
    }

    return null;
  }

  /// Aadhaar Number Validator (Indian ID)
  static String? validateAadhaar(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Aadhaar number is required";
    }

    final digitsOnly = value.trim().replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length != 12) {
      return "Aadhaar must be 12 digits";
    }

    // Basic Verhoeff algorithm check (simplified)
    // For production, implement full Verhoeff validation
    return null;
  }

  /// PAN Card Validator (Indian Tax ID)
  static String? validatePAN(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "PAN is required";
    }

    final pan = value.trim().toUpperCase();

    // PAN format: ABCDE1234F
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(pan)) {
      return "Enter a valid PAN (e.g., ABCDE1234F)";
    }

    return null;
  }

  /// Credit Card Validator
  static String? validateCreditCard(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Card number is required";
    }

    final digitsOnly = value.trim().replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length < 13 || digitsOnly.length > 19) {
      return "Enter a valid card number";
    }

    // Luhn algorithm validation
    int sum = 0;
    bool alternate = false;
    for (int i = digitsOnly.length - 1; i >= 0; i--) {
      int digit = int.parse(digitsOnly[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      alternate = !alternate;
    }

    if (sum % 10 != 0) {
      return "Invalid card number";
    }

    return null;
  }

  /// CVV Validator
  static String? validateCVV(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "CVV is required";
    }

    final digitsOnly = value.trim().replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length < 3 || digitsOnly.length > 4) {
      return "CVV must be 3 or 4 digits";
    }

    return null;
  }

  /// IFSC Code Validator (Indian Bank Code)
  static String? validateIFSC(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "IFSC code is required";
    }

    final ifsc = value.trim().toUpperCase();

    // IFSC format: ABCD0123456
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifsc)) {
      return "Enter a valid IFSC code";
    }

    return null;
  }

  /// Password Strength Checker (returns strength level)
  static String getPasswordStrength(String password) {
    if (password.isEmpty) return "No Password";
    
    int strength = 0;
    
    if (password.length >= 8) strength++;
    if (password.length >= 12) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[a-z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;
    
    if (strength <= 2) return "Weak";
    if (strength <= 4) return "Medium";
    return "Strong";
  }
}