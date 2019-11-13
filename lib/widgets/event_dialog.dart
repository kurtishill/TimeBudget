import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_budget/strings.dart';
import 'package:time_budget/utils/date.dart';

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

  Widget _buildTimeRange() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _selectDate(
                  initialDate: _data['startTime'],
                  onDateTimeChanged: (DateTime newDate) {
                    _data['startTime'] = newDate;
                  });
            },
            child: Column(
              children: <Widget>[
                Text(
                  DateUtils.toyMMMdString(
                    _data['startTime'],
                  ),
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  DateUtils.toClockTime(
                    _data['startTime'],
                  ),
                  style: TextStyle(
                    color: Colors.grey[200],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '-',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
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
            child: Column(
              children: <Widget>[
                Text(
                  DateUtils.toyMMMdString(
                    _data['endTime'],
                  ),
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  DateUtils.toClockTime(
                    _data['endTime'],
                  ),
                  style: TextStyle(
                    color: Colors.grey[200],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: Strings.name,
      ),
      textInputAction: TextInputAction.next,
      validator: (value) {
        return value.isEmpty ? 'Event Name must not be empty' : null;
      },
      onSaved: (value) {
        _data['eventName'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: Strings.description,
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onSaved: (value) {
        _data['eventDescription'] = value;
      },
    );
  }

  Widget _buildCancelButton() {
    return FlatButton(
      child: Text(
        'Cancel',
        style: TextStyle(
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      onPressed: () => Navigator.of(context).pop(null),
    );
  }

  Widget _buildCreateButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: Theme.of(context).accentColor,
        ),
      ),
      color: Colors.white,
      child: Text(
        'Create',
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return null;
        }
        _formKey.currentState.save();
        return Navigator.of(context).pop(_data);
      },
    );
  }

  Widget _buildEventDialog(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                _buildTimeRange(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildNameTextField(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildDescriptionTextField(),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _buildCancelButton(),
                      Expanded(
                        child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width / 2,
                          height: 45,
                          child: _buildCreateButton(),
                        ),
                      ),
                    ],
                  ),
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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: _buildEventDialog(context),
      ),
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
          height: MediaQuery.of(context).size.height / 3,
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
