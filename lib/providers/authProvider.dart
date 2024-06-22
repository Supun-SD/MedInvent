import 'package:MedInvent/features/home/presentation/mainPage.dart';
import 'package:MedInvent/features/login/models/user_model.dart';
import 'package:MedInvent/features/login/presentation/pages/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/Register/models/user_model.dart';

class UserState {
  final User? user;
  final bool isLoading;
  final bool isAuthenticated;
  final String? accessToken;

  UserState({
    required this.user,
    required this.isLoading,
    required this.isAuthenticated,
    required this.accessToken,
  });

  factory UserState.initial() {
    return UserState(
        user: null,
        isLoading: false,
        isAuthenticated: false,
        accessToken: null);
  }
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState.initial());

  Future<void> loginUser(
      String emailOrMobileNo, String password, BuildContext context) async {
    const String username = "admin";
    const String password = "admin";

    if (!(emailOrMobileNo == username && password == password)) {
      _invalidCredentials(context);
      return;
    }

    state = UserState(
        user: state.user,
        isLoading: true,
        isAuthenticated: state.isAuthenticated,
        accessToken: state.accessToken);
    const String userId = "b77565de-75a7-49c6-9335-0478a5d2ff75";
    const String apiURL =
        '${ApiConfig.baseUrl}/patientuser/get/patientuser/details/byuserid/$userId';

    try {
      final response = await http.get(Uri.parse(apiURL));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null) {
          var userJson = jsonResponse['data'];

          User user = User.fromJson(userJson);
          await _onLoginSuccess(username, password, user, context);
          state = UserState(
              user: user,
              isLoading: false,
              isAuthenticated: true,
              accessToken: state.accessToken);
        }
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      _invalidCredentials(context);
    }
  }

  Future<void> registerUser(NewUser user, BuildContext context) async {
    String apiUrl = '${ApiConfig.baseUrl}/patientuser/add/new/patientuser';

    state = UserState(
        user: null, isLoading: true, isAuthenticated: false, accessToken: null);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'userDetails': {
            'Fname': user.fName,
            'Lname': user.lName,
            'mobileNo': user.mobileNo,
            'email': user.email,
            'nic': user.nic,
            'gender': user.gender,
            'dob': user.dob,
            'patientAddress': {
              'lineOne': user.lineOne,
              'lineTwo': user.lineTwo,
              'city': user.city,
              'district': user.district,
              'postalCode': user.postalCode,
            }
          },
          'credentials': {
            'email': user.email,
            'mobileNo': user.mobileNo,
            'password': user.password,
          }
        }),
      );
      if (response.statusCode == 200) {
        _registrationSuccess(context);
      } else {
        _showErrorDialog('Registration failed. Please try again.', context);
      }
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again.', context);
    } finally {
      state = UserState(
          user: null,
          isLoading: false,
          isAuthenticated: false,
          accessToken: null);
    }
  }

  void logoutUser() async {
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = UserState(
        user: null,
        isLoading: state.isLoading,
        isAuthenticated: false,
        accessToken: null);
  }

  void setUser(User user) {
    state = UserState(
        user: user,
        isLoading: state.isLoading,
        isAuthenticated: true,
        accessToken: state.accessToken);
  }

  Future<void> _onLoginSuccess(
      String username, String password, User user, BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(
          sideNavIndex: 2,
        ),
      ),
      (Route<dynamic> route) => false,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  void _registrationSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _invalidCredentials(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Invalid login credentials.'),
          content: const Text(
              'Please enter a valid email or mobile number and password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Registration Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) => UserNotifier(),
);

RegExp emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
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
