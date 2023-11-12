import 'package:MedInvent/data/models/user_model.dart';

abstract class UserDataSource {
  Future<List<UserModel>> getUsers();
  Future<void> insertDoctor(UserModel User);
}