import 'package:MedInvent/config/api.dart';
import 'package:MedInvent/features/login/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final userProvider = StateNotifierProvider<UserStateNotifier, User?>(
    (ref) => UserStateNotifier());

class UserStateNotifier extends StateNotifier<User?> {
  UserStateNotifier() : super(null);

  Future<User> loginUser(String emailOrMobileNo, String password) async {
    const String userId = "10722b9d-590e-4454-b453-7c72a7388a88";

    const String apiURL =
        '${ApiConfig.baseUrl}/patientuser/get/patientuser/details/byuserid/$userId';
    final url = Uri.parse(apiURL);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      state = User.fromJson(jsonData['data']);
      return state!;
    } else {
      throw Exception('Failed to login');
    }
  }

  void setUser(User user) {
    state = user;
  }

  void logoutUser() {
    state = null;
  }
}

RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
RegExp mobileRegex = RegExp(r'^[0-9]{10}$');

// Function to determine if input is email or mobile number
String checkInputType(String input) {
  if (emailRegex.hasMatch(input)) {
    return 'email';
  } else if (mobileRegex.hasMatch(input)) {
    return 'mobile';
  } else {
    return 'unknown';
  }
}
