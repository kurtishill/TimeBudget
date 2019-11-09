import 'package:flutter/material.dart';
import 'package:time_budget/strings.dart';

class EventDialog extends StatelessWidget {
  String _eventName;
  String _eventDescription;
  DateTime _eventStartTime;
  DateTime _eventEndTime;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEventDialog(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            20.0,
            0.0,
            20.0,
            60.0
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: Strings.name
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => {},
                  validator: (value) {
                    return value.isEmpty
                        ? 'Event Name must not be empty'
                        : null;
                  },
                  onSaved: (value) {
                    _eventName = value;
                  }
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: Strings.description,
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => {},
                  validator: (value) => null,
                  onSaved: (value) {
                    _eventDescription = value;
                  }
                )
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