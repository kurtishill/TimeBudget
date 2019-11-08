import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:time_budget/models/category.dart';
import 'package:time_budget/utils/date.dart';
import 'package:time_budget/viewmodels/main/main_bloc.dart';
import 'package:time_budget/viewmodels/main/main_event.dart';
import 'package:time_budget/viewmodels/main/main_state.dart';
import 'package:time_budget/widgets/category_list_item.dart';
import 'package:time_budget/widgets/percentage_ring.dart';

import 'category.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  MainBloc _mainBloc;
  AnimationController _fabController;

  static const List<IconData> fabIcons = const [Icons.calendar_today];
  static const List<String> fabTooltips = const ['Add Activity'];

  @override
  void initState() {
    _mainBloc = BlocProvider.of<MainBloc>(context);
    final now = DateTime.now();
    _mainBloc.add(
      ChangeTimePeriodMainEvent(
        startTime: DateTime(now.year, now.month, now.day, 0, 0),
        endTime: DateTime(now.year, now.month, now.day, 23, 59),
      ),
    );

    _fabController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    super.initState();
  }

  bool _isSameDate(DateTime dt1, DateTime dt2) {
    if (dt1 == null || dt2 == null) {
      return false;
    }
    return dt1.year == dt2.year && dt1.day == dt2.day && dt1.month == dt2.month;
  }

  Future _chooseDate({
    @required BuildContext context,
    @required DateTime dateToChange,
    @required DateTime startTime,
    @required DateTime endTime,
  }) async {
    DateTime initialDate = dateToChange ?? DateTime.now();

    final result = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: dateToChange.compareTo(endTime) == 0
              ? startTime
              : DateTime.now().subtract(Duration(days: 1200)),
          lastDate: dateToChange.compareTo(startTime) == 0
              ? endTime
              : DateTime.now().add(Duration(days: 1200)),
        ) ??
        dateToChange;

    if (_isSameDate(dateToChange, result)) {
      return null;
    }

    return result;
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

  Widget _buildDateSelectionRow(
    BuildContext context,
    DateTime startTime,
    DateTime endTime,
    bool loading,
  ) {
    final innerArrowsEnabled = startTime == null || endTime == null
        ? false
        : !loading && !_isSameDate(startTime, endTime);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: !loading
                  ? () {
                      _mainBloc.add(
                        ChangeTimePeriodMainEvent(
                          startTime: startTime.subtract(
                            Duration(days: 1),
                          ),
                          endTime: endTime,
                        ),
                      );
                    }
                  : null,
            ),
            GestureDetector(
              child: Column(
                children: <Widget>[
                  Text(
                    startTime != null ? DateUtils.toyMMMdString(startTime) : '',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    startTime != null ? DateUtils.toClockTime(startTime) : '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              onTap: !loading
                  ? () async {
                      final DateTime newDate = await _chooseDate(
                        context: context,
                        dateToChange: startTime,
                        startTime: startTime,
                        endTime: endTime,
                      );
                      if (newDate != null) {
                        final newStartTime = DateTime(
                            newDate.year, newDate.month, newDate.day, 0, 0);
                        _mainBloc.add(
                          ChangeTimePeriodMainEvent(
                            startTime: newStartTime,
                            endTime: endTime,
                          ),
                        );
                      }
                    }
                  : null,
            ),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: !_isSameDate(startTime, endTime)
                    ? Colors.grey
                    : Colors.grey[350],
                size: 30,
              ),
              onPressed: innerArrowsEnabled
                  ? () {
                      _mainBloc.add(
                        ChangeTimePeriodMainEvent(
                          startTime: startTime.add(
                            Duration(days: 1),
                          ),
                          endTime: endTime,
                        ),
                      );
                    }
                  : null,
            ),
          ],
        ),
        Text('-'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: !_isSameDate(startTime, endTime)
                    ? Colors.grey
                    : Colors.grey[350],
                size: 30,
              ),
              onPressed: innerArrowsEnabled
                  ? () {
                      _mainBloc.add(
                        ChangeTimePeriodMainEvent(
                          startTime: startTime,
                          endTime: endTime.subtract(
                            Duration(days: 1),
                          ),
                        ),
                      );
                    }
                  : null,
            ),
            GestureDetector(
              child: Column(
                children: <Widget>[
                  Text(
                    endTime != null ? DateUtils.toyMMMdString(endTime) : '',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    endTime != null ? DateUtils.toClockTime(endTime) : '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              onTap: !loading
                  ? () async {
                      final newDate = await _chooseDate(
                        context: context,
                        dateToChange: endTime,
                        startTime: startTime,
                        endTime: endTime,
                      );
                      if (newDate != null) {
                        final newEndTime = DateTime(
                            newDate.year, newDate.month, newDate.day, 23, 59);
                        _mainBloc.add(
                          ChangeTimePeriodMainEvent(
                            startTime: startTime,
                            endTime: newEndTime,
                          ),
                        );
                      }
                    }
                  : null,
            ),
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: !loading
                  ? () {
                      _mainBloc.add(
                        ChangeTimePeriodMainEvent(
                          startTime: startTime,
                          endTime: endTime.add(
                            Duration(days: 1),
                          ),
                        ),
                      );
                    }
                  : null,
            ),
          ],
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
        timePeriodLengthInSeconds: seconds,
      ),
      child: child,
    );
  }

  Widget _buildSummaryRow(int numActivities, int seconds, double percent) {
    String percentString;
    if (percent == null) {
      percentString = '0';
    } else {
      percentString = percent.floor() == percent
          ? percent.toStringAsFixed(0)
          : percent.toStringAsFixed(1);
    }
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

  Widget _buildCategoryList(
    List<Category> categories,
    DateTime startTime,
    DateTime endTime,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, i) => CategoryListItem(
        category: categories[i],
        startTime: startTime,
        endTime: endTime,
        onTap: _onCategoryTapped,
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: new List.generate(fabIcons.length, (int index) {
        Widget child = new Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: new ScaleTransition(
            scale: new CurvedAnimation(
              parent: _fabController,
              curve: new Interval(
                0.0,
                1.0 - index / fabIcons.length / 2.0,
                curve: Curves.easeOut,
              ),
            ),
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: 50,
                  top: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            offset: new Offset(0.0, 5.0),
                            blurRadius: 7.0,
                            spreadRadius: -5.0,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(fabTooltips[index]),
                    ),
                  ),
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.white,
                  mini: true,
                  child: new Icon(fabIcons[index], color: Colors.amber),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          new FloatingActionButton(
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _fabController,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform: new Matrix4.rotationZ(
                    _fabController.value * 0.75 * math.pi,
                  ),
                  alignment: FractionalOffset.center,
                  child: new Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                );
              },
            ),
            onPressed: () {
              if (_fabController.isDismissed) {
                _fabController.forward();
              } else {
                _fabController.reverse();
              }
            },
          ),
        ),
    );
  }

  Widget _buildPageContent({
    @required BuildContext context,
    @required DateTime startTime,
    @required DateTime endTime,
    @required double ringRadius,
    @required List<Category> categories,
    @required int seconds,
    @required bool loading,
  }) {
    double hours;
    int startToEndTime;
    double percent;
    if (startTime != null && endTime != null) {
      hours = seconds / 3600;
      startToEndTime = endTime.difference(startTime).inSeconds;
      percent = seconds / startToEndTime * 100;
    }
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
            _buildDateSelectionRow(context, startTime, endTime, loading),
            SizedBox(
              height: 60.0,
            ),
            Container(
              width: ringRadius * 2 - 20,
              height: ringRadius * 2 - 20,
              child: _buildPercentageRing(
                categories: categories,
                radius: ringRadius,
                seconds: startToEndTime,
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
              child: _buildSummaryRow(categories.length, seconds, percent),
            ),
            SizedBox(
              height: 20,
            ),
            _buildTimeSpentRow(Theme.of(context).accentColor),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: _buildCategoryList(categories, startTime, endTime),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double ringRadius = MediaQuery.of(context).size.width / 4;

    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder(
        bloc: _mainBloc,
        builder: (context, state) {
          return _buildPageContent(
            context: context,
            startTime: state is TimeMainState ? state.startTime : null,
            endTime: state is TimeMainState ? state.endTime : null,
            ringRadius: ringRadius,
            categories: state is LoadedMainState ? state.categories : [],
            seconds: state is LoadedMainState ? state.totalSeconds : 0,
            loading: state is LoadingMainState,
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  void _onCategoryTapped(
    Category category,
    DateTime startTime,
    DateTime endTime,
  ) {
    Navigator.of(context).pushNamed(
      CategoryView.routeName,
      arguments: Map<String, dynamic>.of({
        'category': category,
        'startTime': startTime,
        'endTime': endTime,
      }),
    );
  }
}
