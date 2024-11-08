import 'package:flutter/material.dart';
import 'package:xpinso/models/transaction_model.dart'; // Import your model to use Recurrence enum

class RecurrenceDropdown extends StatelessWidget {
  final Recurrence selectedRecurrence;
  final Function(Recurrence) onRecurrenceChanged;

  RecurrenceDropdown({
    required this.selectedRecurrence,
    required this.onRecurrenceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Recurrence>(
      value: selectedRecurrence,
      onChanged: (Recurrence? newValue) {
        if (newValue != null) {
          onRecurrenceChanged(newValue);
        }
      },
      items: Recurrence.values.map((Recurrence recurrence) {
        return DropdownMenuItem<Recurrence>(
          value: recurrence,
          child: Text(recurrence.toString().split('.').last), // Show the enum name
        );
      }).toList(),
    );
  }
}
