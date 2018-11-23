import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:better_yunar/actions/registration.dart';

class WaitForVerificationScreenModel {
  bool readyToGo;

  WaitForVerificationScreenModel(AppState state)
    : readyToGo = true;
}

class WaitForVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, WaitForVerificationScreenModel>(
      converter: (state) => WaitForVerificationScreenModel(state),
      builder: (context, dispatcher, model) {
        return RaisedButton(
          child: Text("I clicked the email button"),
          onPressed: () {
            dispatcher(VerificationEmailClicked());
          },
        );
      }
    );
  }
}