import 'dart:async';
import 'package:rebloc/rebloc.dart';
import '../models/app_state.dart';
import 'package:better_yunar/actions/onboarding.dart';
import 'package:better_yunar/data/web_client.dart';

const registerUrl = 'https://api.dev1.thatisnomoon.io/onboarding';

class UserOnboardingStartedBloc extends SimpleBloc<AppState> {
  void _onboardUser({ String nickname, DispatchFunction dispatcher }) async {
    WebClient client = WebClient.instance();
    await client.onboard(nickname);

    // var body = json.encode({ 'nickname': username });
    // final response = await client.doNonJWTRequest(url: registerUrl, body: body);
    // if (response.statusCode != 201) {
    //   final responseBody = json.decode(response.body);
    //   return dispatcher(UserRegistrationFailed(failureReason: 'Something went wrong: ' + responseBody['detail']));
    // }
    // final responseBody = json.decode(response.body);
    // final user = UserState.fromJson(responseBody);
    dispatcher(UserOnboarded());
  }

  @override
    FutureOr<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) {
      if (action is UserOnboardingStarted) {
        _onboardUser(nickname: action.nickname, dispatcher: dispatcher);
      }
      return action;
    }
  @override
    AppState reducer(AppState state, Action action) {
      if (action is UserOnboardingStarted) {
        return state.rebuild((builder) {
          builder.onboarding.isOnboardingRequestRunning = true;
        });
      }
      return state;
    }
  
}

class UserOnboardingFailedBloc extends SimpleBloc<AppState> {
  @override
    AppState reducer(AppState state, Action action) {
      if (action is UserOnboardingFailed) {
        return state.rebuild((builder) {
          builder.onboarding.isOnboardingRequestRunning = false;
          builder.onboarding.onboardingRequestErrorMessage = action.failureReason;
        });
      }
      return state;
    }
}

class UserOnboardingSucceededBlob extends SimpleBloc<AppState> {
  @override
    AppState reducer(AppState state, Action action) {
      if (action is UserOnboarded) {
        return state.rebuild((builder) {
          builder.onboarding.isOnboardingRequestRunning = false;
          builder.onboarding.onboardingRequestErrorMessage = null;
          builder.user.nickname = action.nickname;
          builder.user.userId = action.userId;
          builder.user.username = action.username;
          builder.user.password = action.password;
        });
      }
      return state;
    }
}

var blocs = [
  UserOnboardingStartedBloc(),
  UserOnboardingFailedBloc(),
  UserOnboardingSucceededBlob()
];