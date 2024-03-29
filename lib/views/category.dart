import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/viewmodels/bloc.dart';
import 'package:time_budget/viewmodels/category/category_bloc.dart';
import 'package:time_budget/widgets/event_list_item.dart';

class CategoryView extends StatefulWidget {
  static const routeName = '/category';

  final Category category;
  final DateTime startTime;
  final DateTime endTime;

  CategoryView({
    @required this.category,
    @required this.startTime,
    @required this.endTime,
  });

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  CategoryBloc _categoryBloc;

  @override
  void didChangeDependencies() {
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    _categoryBloc.add(
      FetchEventsCategoryEvent(
        categoryId: widget.category.id,
        startTime: widget.startTime,
        endTime: widget.endTime,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: BlocBuilder(
        bloc: _categoryBloc,
        builder: (context, state) {
          if (state is EventsLoadedCategoryState) {
            return ListView.builder(
              itemCount: state.events.length,
              itemBuilder: (context, i) => EventListItem(
                event: state.events[i],
                onDelete: _deleteEvent,
              ),
            );
          } else if (state is LoadingCategoryState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _deleteEvent(int eventId) {
    _categoryBloc.add(
      DeleteEventCategoryEvent(
        categoryId: widget.category.id,
        eventId: eventId,
      ),
    );
  }
}
