import 'package:flutter/material.dart';

void _showSuccessDialog() {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Success'),
      content: Text('Your account has been created successfully!'),
      actions: <Widget>[
        TextButton(
          child: Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
            // Navigate to the home screen or login screen
          },
        )
      ],
    ),
  );
}
