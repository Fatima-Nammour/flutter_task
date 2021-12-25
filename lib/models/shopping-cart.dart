import 'package:hive/hive.dart';

part 'shopping-cart.g.dart';

@HiveType(typeId: 2)
class ShoppingCart extends HiveObject {
  @HiveField(0)
  String? imageUrl;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? price;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? rate;
  @HiveField(5)
  String? marketName;
  @HiveField(6)
  String? marketAddress;
  @HiveField(7)
  int? id;
}
