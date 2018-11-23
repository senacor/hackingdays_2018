import 'package:rebloc/rebloc.dart';
import 'package:better_yunar/models/onboardingResponse.dart';

class UserOnboardingStarted extends Action {
  String nickname;

  UserOnboardingStarted({ this.nickname });
}

class UserOnboardingFailed extends Action {
  String failureReason;

  UserOnboardingFailed({ this.failureReason });
}

class UserOnboarded extends Action {
  OnboardingResponse onboardingResponse;

  UserOnboarded({ this.onboardingResponse });
}