import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:time_budget/views/calendar.dart';
import 'package:time_budget/views/report.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  final _tabs = <Widget>[
    ReportView(),
    CalendarView(),
  ];

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Time Budget'),
      leading: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Logout'),
              ],
            ),
          ),
        ],
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      ),
      bottom: TabBar(
        tabs: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Report'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Calendar'),
          ),
        ],
        controller: _tabController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: TabBarView(
        children: _tabs,
        controller: _tabController,
      ),
    );
  }
}
