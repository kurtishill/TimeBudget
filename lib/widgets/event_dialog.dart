import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_budget/strings.dart';
import 'package:intl/intl.dart';

class EventDialog extends StatefulWidget {
  @override
  _EventDialogState createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  final Map<String, dynamic> _data = {
    'eventName': null,
    'eventDescription': null,
    'startTime': DateTime.now(),
    'endTime': DateTime.now().add(new Duration(minutes: 15)),
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEventDialog(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(labelText: Strings.name),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => {},
                    validator: (value) {
                      return value.isEmpty
                          ? 'Event Name must not be empty'
                          : null;
                    },
                    onSaved: (value) {
                      _data['eventName'] = value;
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: Strings.description,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    onFieldSubmitted: (_) => {},
                    validator: (value) => null,
                    onSaved: (value) {
                      _data['eventDescription'] = value;
                    }),
                GestureDetector(
                  onTap: () {
                    _selectDate(
                        initialDate: _data['startTime'],
                        onDateTimeChanged: (DateTime newDate) {
                          _data['startTime'] = newDate;
                        });
                  },
                  child: Row(
                    children: <Widget>[
                      Text('Start Time'),
                      Spacer(),
                      Text(DateFormat('EEE, MMM d, yyyy - hh:mm aaa')
                          .format(_data['startTime'])),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _selectDate(
                        initialDate: _data['endTime'],
                        onDateTimeChanged: (DateTime newDate) {
                          _data['endTime'] = newDate;
                        });
                  },
                  child: Row(
                    children: <Widget>[
                      Text('End Time'),
                      Spacer(),
                      Text(DateFormat('EEE, MMM d, yyyy - hh:mm aaa')
                          .format(_data['endTime'])),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(null),
                    ),
                    FlatButton(
                      child: Text(
                        'Create',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return null;
                        }
                        _formKey.currentState.save();
                        return Navigator.of(context).pop(_data);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _buildEventDialog(context),
    );
  }

  void _selectDate({
    @required DateTime initialDate,
    @required Function onDateTimeChanged,
  }) async {
    return await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: CupertinoDatePicker(
            initialDateTime: initialDate,
            onDateTimeChanged: (DateTime newEndTime) {
              setState(
                () => onDateTimeChanged(newEndTime),
              );
            },
            minuteInterval: 1,
            mode: CupertinoDatePickerMode.dateAndTime,
          ),
        );
      },
    );
  }
}
