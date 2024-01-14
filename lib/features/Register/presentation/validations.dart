
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

String? nameValidation(String value, String field) {

  final RegExp regex = RegExp(r'^[a-zA-Z]+$');

  if(value.isEmpty){
    return '$field cannot be empty';
  }
  if(!regex.hasMatch(value)){
    return "$field can only contain letters";
  }
  return null;
}