import 'package:flutter/material.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/utils/date.dart';

class CategoryListItem extends StatelessWidget {
  final Category category;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;
  final double percentage;
  final Function onTap;

  CategoryListItem({
    @required this.category,
    @required this.startTime,
    @required this.endTime,
    @required this.color,
    @required this.percentage,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String percentString;
    if (percentage == null) {
      percentString = '0';
    } else {
      percentString = percentage.floor() == percentage
          ? percentage.toStringAsFixed(0)
          : percentage.toStringAsFixed(1);
    }
    return ListTile(
      // leading: Icon(
      //   Icons.more_vert,
      //   color: color,
      // ),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${category.events.length}',
            style: TextStyle(
              color: color,
              fontSize: 16,
            ),
          ),
        ],
      ),
      title: Text(
        category.name,
        style: TextStyle(
          color: color,
        ),
      ),
      subtitle: Text(
        DateUtils.toHoursAndMinutes(
          category.amountOfTimeToDateTime(),
        ),
      ),
      trailing: Text(
        '$percentString%',
        style: TextStyle(
          color: color,
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
