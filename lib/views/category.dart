import 'package:flutter/material.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/widgets/event_list_item.dart';

class CategoryView extends StatelessWidget {
  final Category category;

  CategoryView({@required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: ListView.builder(
        itemCount: category.events.length,
        itemBuilder: (context, i) => EventListItem(category.events[i]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
