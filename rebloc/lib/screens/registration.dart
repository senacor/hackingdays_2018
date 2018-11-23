import 'package:flutter/material.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:rebloc/rebloc.dart';
import 'package:better_yunar/models/loyaltyCard.dart';
import 'package:better_yunar/actions/registration.dart';

class RegistrationViewModel {
  final List<LoyaltyCard> loyaltyCards;

  RegistrationViewModel(AppState state): this.loyaltyCards = state.loyaltyCards.values.toList();
}

class RegistrationScreen extends StatefulWidget {
  @override
  RegistrationScreenState createState() {
    return RegistrationScreenState();
  }
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String mailAddress;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('From onboarded to registered'),
      ),
      body: ViewModelSubscriber<AppState, RegistrationViewModel>(
        converter: (state) => RegistrationViewModel(state),

        builder: (context, dispatcher, viewModel) {
          return Form(
            key: _formKey,

            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter mail address';
                    } else {
                      mailAddress = value;
                    }
                  },
                ),

                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    } else {
                      password = value;
                    }
                  },
                ),

                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      dispatcher(RegistrationStarted(mailaddress: mailAddress, password: password));
                    }
                  },
                  child: Text('Submit'),
                ),
              ]
            )
          );
        }
      )
    );
  }
}