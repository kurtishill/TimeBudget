import 'package:flutter/material.dart';
import 'package:time_budget/strings.dart';

class EventDialog extends StatelessWidget {
  final Function onCreateEvent;

  final Map<String, dynamic> _data = {
    'eventName': null,
    'eventDescription': null,
    'startTime': null,
    'endTime': null,
  };

  EventDialog({
    @required this.onCreateEvent,
  });

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
                    onFieldSubmitted: (_) => {},
                    validator: (value) => null,
                    onSaved: (value) {
                      _data['eventDescription'] = value;
                    }),
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
                      onPressed: () => Navigator.of(context).pop(_data),
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
}
