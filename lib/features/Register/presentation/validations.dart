import 'package:intl/intl.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email address cannot be empty';
  }
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validateMobileNo(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number cannot be empty';
  }
  final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
  if (!numericValue.startsWith('07') || numericValue.length != 10) {
    return 'Enter a valid mobile number';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!RegExp(r'\d').hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  return null;
}

String? confirmPassword(String? value, String? confirmPassword) {
  if (value == null || value.isEmpty) {
    return 'Confirm the password';
  }
  if (confirmPassword != null && confirmPassword != value) {
    return 'Passwords do not match';
  }
  return null;
}

String? emptyValidation(String? value, String field){
  if(value == null || value.isEmpty){
    return '$field cannot be empty';
  }
  return null;
}

String? dobValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Date of birth is required';
  }

  final RegExp dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');

  if (!dateRegex.hasMatch(value)) {
    return 'Invalid format';
  }
  try {
    DateFormat('yyyy-MM-dd').parseStrict(value);
  } catch (e) {
    return 'Entered date is not a valid date';
  }
  return null;
}