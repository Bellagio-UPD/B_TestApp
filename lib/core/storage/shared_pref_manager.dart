import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static const String _accessTokenKey = 'access_token';
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _loyaltyProgramId = 'loyalty_program_id';
  static const String _packageId = 'package_id';
  static const String _managerIdKey = 'manager_id';
  static const String _emailKey = 'email';
  static const String _phoneNumberKey = 'phoneNumber';
  static const String _bellagioIdKey = 'bellagioId';
  static const String _bellagioPoints = 'bellagioPoints';
  static const String _otpPointsKey = 'otp_points';
  static const String _registrationQRKey = 'registration_QR';
  static const String _firstname = 'firstname';
  static const String _lastname = 'lastname';
  String? _cachedToken;

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    _cachedToken = token;
  }

  Future<String?> getToken() async {
    if (_cachedToken != null) {
      return _cachedToken;
    }

    final prefs = await SharedPreferences.getInstance();
    _cachedToken = prefs.getString(_accessTokenKey);
    return _cachedToken;
  }

  // Save User ID
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  // Retrieve User ID
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Save and retrieve marketing executive id

  Future<void> saveManagerId(String managerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_managerIdKey, managerId);
  }

  Future<String?> getManagerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_managerIdKey);
  }

// Save and retrieve username
  Future<void> saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, userName);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // Save and retrieve email
  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  // Save and retrieve phoneNumber
  Future<void> savePhoneNumber(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneNumberKey, phoneNumber);
  }

  Future<String?> getPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneNumberKey);
  }

  // save and retrieve loyalty program id
  Future<void> saveLoyaltyProgramId(String loyaltyProgramId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loyaltyProgramId, loyaltyProgramId);
  }

  Future<String?> getLoyaltyProgramId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_loyaltyProgramId);
  }

  // save and retrieve package id
  Future<void> savePackageId(String packageId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_packageId, packageId);
  }

  Future<String?> getPackageId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_packageId);
  }

  // save and retrieve bellagio id
  Future<void> saveBellagioId(String bellagioId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bellagioIdKey, bellagioId);
  }

  Future<String?> getBellagioId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_bellagioIdKey);
  }

  // save and retrieve bellagio points
  Future<void> saveBellagioPoints(String bellagioPoints) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bellagioPoints, bellagioPoints);
  }

  Future<String?> getBellagioPoints() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_bellagioPoints);
  }

  // save and retrieve bellagio otp points
  Future<void> saveOTPPoints(String otp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_otpPointsKey, otp);
  }

  Future<String?> getOTPPoints() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_otpPointsKey);
  }

  // save and retrieve bellagio otp points
  Future<void> saveQRCode(String qrCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_registrationQRKey, qrCode);
  }

  Future<String?> getQRCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_registrationQRKey);
  }


    Future<void> saveFirstName(String firstname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_firstname, firstname);
  }

  Future<String?> getFirstname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_firstname);
  }

      Future<void> saveLastName(String lastname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastname, lastname);
  }

  Future<String?> getLastname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastname);
  }



  // Clear All Data for Logout
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This clears all data stored in SharedPreferences
  }

  Future<void> clearTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    _cachedToken = "";
  }

  Future<void> clearManagerId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_managerIdKey);
  }
}
