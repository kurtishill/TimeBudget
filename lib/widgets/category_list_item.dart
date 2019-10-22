import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/views/category.dart';

class CategoryListItem extends StatelessWidget {
  final Category category;

  CategoryListItem({@required this.category});

  final DateFormat dateFormat = DateFormat("h 'hours' m 'minutes'");
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.more_vert,
        color: Colors.lightGreen,
      ),
      title: Text(
        category.name,
      ),
      subtitle: Text(
        dateFormat.format(category.timeForEventsToDateTime()),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryView(
              category: category,
            ),
          ),
        );
      },
    );
  }
}
