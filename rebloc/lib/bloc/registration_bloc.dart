import 'dart:async';
import 'package:rebloc/rebloc.dart';
import '../models/app_state.dart';
import 'package:better_yunar/actions/registration.dart';
import 'package:better_yunar/data/web_client.dart';
import 'package:better_yunar/models/password.dart';
import 'package:better_yunar/bloc/navigation_bloc.dart';

class RegistrationBloc extends SimpleBloc<AppState> {
  WebClient client;

  RegistrationBloc(){
    client = WebClient.instance();
  }

  @override
  FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) async {
    if (action is RegistrationStarted) {
      Password password;
      try{
        password = await client.register(action.mailaddress, action.password);
      } catch(e) {
        dispatcher(RegistrationStartedFailed(failureReason: e.toString()));
      }

      dispatcher(RegistrationSent());
    }

    if(action is RegistrationSent) {
      dispatcher(PushNamedRouteAction('/waitForVerification'));
    }

    if(action is VerificationEmailClicked) {
      await client.getMe();
      dispatcher(PushNamedRouteAction('/mainScreen'));
    }

    return action;
  }
}

var blocs = [
  RegistrationBloc(),
];