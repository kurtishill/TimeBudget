import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_budget/models/event.dart';
import 'package:time_budget/utils/date.dart';

class EventListItem extends StatelessWidget {
  final Event event;
  final Function onDelete;

  EventListItem({
    @required this.event,
    @required this.onDelete,
  });

  Widget _buildListItem(BuildContext context, Event event) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(event.name),
          subtitle: Text(event.description ?? ''),
          trailing: Text(
            DateUtils.eventToHoursAndMinutes(
              event.start,
              event.end,
              event.getTotalTimeAsDateTime(),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16.0),
          height: 1,
          width: double.infinity,
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(event.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _showDialog(context),
      onDismissed: (_) => this.onDelete(this.event.id),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Icon(
          Icons.delete_forever,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 40),
        margin: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
      ),
      child: _buildListItem(context, event),
    );
  }

  Future<bool> _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to remove this event?'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: Text(
              'Yes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );
  }
}
