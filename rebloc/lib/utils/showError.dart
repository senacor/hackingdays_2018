
import 'package:flutter/material.dart';

showError({ message, scaffoldKey }) {
  scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: new Text('Error: ${message}'),
        duration: new Duration(seconds: 5),
      )
    );
}