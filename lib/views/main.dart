import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/viewmodels/main/main_bloc.dart';
import 'package:time_budget/viewmodels/main/main_event.dart';
import 'package:time_budget/viewmodels/main/main_state.dart';
import 'package:time_budget/widgets/category_list_item.dart';
import 'package:time_budget/widgets/percentage_ring.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  MainBloc _mainBloc;

  @override
  void initState() {
    _mainBloc = BlocProvider.of<MainBloc>(context);
    _mainBloc.add(ChangeDateMainEvent(newDate: DateTime.now()));
    super.initState();
  }

  bool _isSameDate(DateTime dt1, DateTime dt2) {
    return dt1.year == dt2.year && dt1.day == dt2.day && dt1.month == dt2.month;
  }

  Future _chooseDate(BuildContext context, DateTime startDate) async {
    DateTime initialDate = startDate ?? DateTime.now();

    final result = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime.now().subtract(Duration(days: 1200)),
          lastDate: DateTime.now().add(Duration(days: 1200)),
        ) ??
        startDate;

    if (!_isSameDate(startDate, result)) {
      _mainBloc.add(ChangeDateMainEvent(newDate: result));
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Time Budget'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDateSelectionRow(BuildContext context, DateTime date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.grey,
            size: 40,
          ),
          onPressed: date != null
              ? () {
                  _mainBloc.add(
                    ChangeDateMainEvent(
                      newDate: date.subtract(
                        Duration(days: 1),
                      ),
                    ),
                  );
                }
              : null,
        ),
        Spacer(),
        GestureDetector(
          child: Text(
            date != null ? DateFormat.yMMMd().format(date) : '',
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
          ),
          onTap: () => _chooseDate(context, date),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
            size: 40,
          ),
          onPressed: date != null
              ? () {
                  _mainBloc.add(
                    ChangeDateMainEvent(
                      newDate: date.add(
                        Duration(days: 1),
                      ),
                    ),
                  );
                }
              : null,
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildPercentageRing({
    List<Category> categories,
    double radius,
    int seconds,
    Widget child,
  }) {
    return CustomPaint(
      painter: PercentageRing(
        categories: categories,
        radius: radius,
      ),
      child: child,
    );
  }

  Widget _buildSummaryRow(int numActivities, int seconds) {
    double percent = seconds / 86400 * 100;
    String percentString = percent.floor() == percent
        ? percent.toStringAsFixed(0)
        : percent.toStringAsFixed(1);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              '$numActivities',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: 100,
                child: Text(
                  'Activities',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              '$percentString%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: 100,
                child: Text(
                  'Daily Hours Budgeted',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSpentRow(Color fontColor) {
    return Row(
      children: <Widget>[
        Spacer(
          flex: 1,
        ),
        Text(
          'Time spent per category',
          style: TextStyle(
            color: fontColor,
            fontSize: 18,
          ),
        ),
        Spacer(
          flex: 5,
        ),
      ],
    );
  }

  Widget _buildCategoryList(List<Category> categories) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, i) => CategoryListItem(
        category: categories[i],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _buildPageContent({
    @required BuildContext context,
    @required DateTime date,
    @required double ringRadius,
    @required List<Category> categories,
    @required int seconds,
    @required bool loading,
  }) {
    final hours = seconds / 3600;
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            _buildDateSelectionRow(context, date),
            SizedBox(
              height: 60.0,
            ),
            Container(
              width: ringRadius * 2 - 20,
              height: ringRadius * 2 - 20,
              child: _buildPercentageRing(
                categories: categories,
                radius: ringRadius,
                seconds: seconds,
                child: loading
                    ? Container(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: Text(
                          seconds != 0
                              ? '${hours.floor() == hours ? hours.toStringAsFixed(0) : hours.toStringAsFixed(2)} Hours'
                              : '',
                          style: TextStyle(fontSize: ringRadius / 4),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: _buildSummaryRow(categories.length, seconds),
            ),
            SizedBox(
              height: 20,
            ),
            _buildTimeSpentRow(Theme.of(context).accentColor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: _buildCategoryList(categories),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double ringRadius = MediaQuery.of(context).size.width / 4;

    final totalSecondsForDay = _mainBloc.categories.fold(
      0,
      (t, c) => t + c.totalTimeForEventsToSeconds(),
    );

    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder(
        bloc: _mainBloc,
        builder: (context, state) {
          return _buildPageContent(
            context: context,
            date: state is LoadedMainState ? state.date : null,
            ringRadius: ringRadius,
            categories: state is LoadedMainState ? state.categories : [],
            seconds: state is LoadedMainState ? totalSecondsForDay : 0,
            loading: state is LoadingMainState,
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}
