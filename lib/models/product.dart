import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
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
