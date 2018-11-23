import 'dart:async';
import 'package:rebloc/rebloc.dart';
import '../models/app_state.dart';
import 'package:better_yunar/actions/onboarding.dart';
import 'package:better_yunar/models/onboardingResponse.dart';
import 'package:better_yunar/data/web_client.dart';
import 'package:better_yunar/models/user.dart';
import 'package:flutter/material.dart';
import 'package:better_yunar/bloc/navigation_bloc.dart';

const registerUrl = 'https://api.dev1.thatisnomoon.io/onboarding';

class UserOnboardingStartedBloc extends SimpleBloc<AppState> {
  void _onboardUser({ String nickname, DispatchFunction dispatcher }) async {
    WebClient client = WebClient.instance();
    OnboardingResponse onboardingResponse = await client.onboard(nickname);
    await client.initOauth(onboardingResponse.auth.username, onboardingResponse.auth.password, onboardingResponse.onboardedUser.userId);

    dispatcher(UserOnboarded(onboardingResponse: onboardingResponse));
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
          builder.onboardingScreen.isOnboardingRequestRunning = true;
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
          builder.onboardingScreen.isOnboardingRequestRunning = false;
          builder.onboardingScreen.onboardingRequestErrorMessage = action.failureReason;
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
          builder.onboardingScreen.isOnboardingRequestRunning = false;
          builder.onboardingScreen.onboardingRequestErrorMessage = null;

          builder.user.userId = action.onboardingResponse.onboardedUser.userId;
          builder.user.username = action.onboardingResponse.auth.username;
          builder.user.password = action.onboardingResponse.auth.password;
          builder.user.nickname = action.onboardingResponse.onboardedUser.nickname;
        });
      }
      return state;
    }

    @override
      FutureOr<Action> afterware(DispatchFunction dispatcher, AppState state, Action action) {
        if(action is UserOnboarded) {
          dispatcher(PushNamedReplacementRouteAction('/mainScreen'));
        }
      }
}

var blocs = [
  UserOnboardingStartedBloc(),
  UserOnboardingFailedBloc(),
  UserOnboardingSucceededBlob()
];