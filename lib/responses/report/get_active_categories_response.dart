import 'package:time_budget/responses/report/active_category.dart';
import 'package:time_budget/serialization/decodable.dart';

class GetActiveCategoriesResponse extends Decodable {
  final List<dynamic> categories;

  GetActiveCategoriesResponse({
    this.categories,
  });

  @override
  Decodable fromJson(Map<String, dynamic> json) {
    final response = GetActiveCategoriesResponse(
      categories: json['categories'],
    );
    List<ActiveCategory> categories = [];

    response.categories.forEach((r) {
      categories.add(ActiveCategory().fromJson(r));
    });

    return GetActiveCategoriesResponse(categories: categories);
  }
}
