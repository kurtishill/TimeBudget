import 'package:time_budget/serialization/encodable.dart';

class CreateEventRequest extends Encodable {
  final String userID;
  final String description;
  final String startAt;
  final String endAt;
  final String categoryId;

  CreateEventRequest({
    this.userID,
    this.description,
    this.startAt,
    this.endAt,
    this.categoryId,
  });

  @override
  Map<String, dynamic> toJson() => {
        "userID": userID,
        "description": description,
        "startAt": startAt,
        "endAt": endAt,
        "categoryID": categoryId,
      };
}
