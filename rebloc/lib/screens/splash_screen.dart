import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:hello_world/models/app_state.dart';

class SplashScreenViewModel {
  bool readyToGo;

  SplashScreenViewModel(AppState state)
    : readyToGo = state.loyaltyCards.length > 0;
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelSubscriber<AppState, SplashScreenViewModel>(
      converter: (state) => SplashScreenViewModel(state),
      builder: (context, dispatcher, model) {
        if(model.readyToGo == true) {
          //TODO
          // Make this clever
          // Make sure the splash screen is shown at least a couple of seconds
          Future.delayed(Duration(milliseconds: 1000), () => Navigator.of(context).pushReplacementNamed('/mainScreen'));
        }
      
        return Text('THAT IS A SPLASH SCREEN');
      }
    );
  }
}