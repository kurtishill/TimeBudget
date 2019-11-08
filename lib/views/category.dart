import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/viewmodels/bloc.dart';
import 'package:time_budget/viewmodels/category/category_bloc.dart';
import 'package:time_budget/widgets/event_list_item.dart';

class CategoryView extends StatefulWidget {
  static const routeName = '/category';

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  Category _category;
  CategoryBloc _categoryBloc;

  @override
  void didChangeDependencies() {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    _category = arguments['category'] as Category;
    final startTime = arguments['startTime'] as DateTime;
    final endTime = arguments['endTime'] as DateTime;
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    _categoryBloc.add(
      FetchEventsCategoryEvent(
        categoryId: _category.id,
        startTime: startTime,
        endTime: endTime,
      ),
    );
    super.didChangeDependencies();
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_category.name),
      ),
      body: BlocListener(
        bloc: _categoryBloc,
        listener: (context, state) {
          if (state is EventDeletedCategoryState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Deleting event was ${state.success ? 'successful!' : 'unsuccessful'}',
                ),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: BlocBuilder(
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
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  void _deleteEvent(int eventId) {
    _categoryBloc.add(
      DeleteEventCategoryEvent(eventId: eventId),
    );
  }
}
