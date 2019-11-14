import 'package:time_budget/serialization/decodable.dart';

class ActiveCategory extends Decodable {
  final int categoryID;
  final int userID;
  final String description;
  final int deletedAt;
  final int color;

  ActiveCategory({
    this.categoryID,
    this.userID,
    this.description,
    this.deletedAt,
    this.color,
  });

  @override
  Decodable fromJson(Map<String, dynamic> json) => ActiveCategory(
        categoryID: json['categoryID'],
        userID: json['userID'],
        description: json['description'],
        deletedAt: json['deletedAt'],
        color: json['color'],
      );
}
