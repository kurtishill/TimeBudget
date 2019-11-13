import 'package:time_budget/serialization/encodable.dart';

class DeleteEventRequest extends Encodable {
  final int eventID;

  DeleteEventRequest({
    this.eventID,
  });

  @override
  Map<String, dynamic> toJson() => {
        "eventID": eventID,
      };
}
