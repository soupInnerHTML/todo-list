import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomForm extends StatefulWidget {
  final String action;
  final Function callback;
  final String? initialValue;

  CustomForm({required this.action, required this.callback, this.initialValue});

  @override
  _CustomFormState createState() {
    return _CustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class _CustomFormState extends State<CustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<CustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String? listItemText;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; //translation
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return t.enterSomeText;
                  }
                  return null;
                },
                onSaved: (String? value) {
                  listItemText = value!.trim();
                },
                autofocus: true,
                initialValue: widget.initialValue,
                maxLength: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        _formKey.currentState!.save();
                        widget.callback(listItemText);

                        if (widget.action == 'Edit') {
                          Navigator.pop(context);
                        } else {
                          _formKey.currentState!.reset();
                        }
                      }
                    },
                    child: Text(widget.action),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(t.cancel),
                ),
              ]),
            )
          ]),
    );
  }
}
