import 'package:flutter_task/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  User? _user;

  User? get user => _user;
  void set(User? user) => _user = user;
}
