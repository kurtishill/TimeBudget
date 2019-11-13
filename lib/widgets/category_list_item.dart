import 'package:flutter/material.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/utils/date.dart';

class CategoryListItem extends StatelessWidget {
  final Category category;
  final DateTime startTime;
  final DateTime endTime;
  final Function onTap;

  CategoryListItem({
    @required this.category,
    @required this.startTime,
    @required this.endTime,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.more_vert,
        color: Colors.lightGreen,
      ),
      title: Text(category.name),
      subtitle: Text(
        DateUtils.toHoursAndMinutes(
          category.amountOfTimeToDateTime(),
        ),
      ),
      onTap: () => this.onTap(
        category,
        startTime,
        endTime,
      ),
    );
  }
}
