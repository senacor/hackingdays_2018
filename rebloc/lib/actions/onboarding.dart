import 'package:rebloc/rebloc.dart';

class UserOnboardingStarted extends Action {
  String nickname;

  UserOnboardingStarted({ this.nickname });
}

class UserOnboardingFailed extends Action {
  String failureReason;

  UserOnboardingFailed({ this.failureReason });
}

class UserOnboarded extends Action {
  String userId;
  String username;
  String password;
  String nickname;

  UserOnboarded({ this.userId, this.username, this.password, this.nickname });
}