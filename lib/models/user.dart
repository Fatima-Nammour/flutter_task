import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? fullName;
  @HiveField(2)
  String? password;
  @HiveField(3)
  String? number;
  @HiveField(4)
  String? city;
  @HiveField(5)
  bool? isLogged;
  @HiveField(6)
  bool? isEmptyShoppingCart;
  @HiveField(7)
  bool? isSignup = false;
}
