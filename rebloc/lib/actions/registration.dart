import 'package:rebloc/rebloc.dart';

class RegistrationStarted extends Action {
  String mailaddress;
  String password;

  RegistrationStarted({ this.mailaddress, this.password });
}

class RegistrationStartedFailed extends Action {
  String failureReason;

  RegistrationStartedFailed({ this.failureReason });
}

class RegistrationSent extends Action {
  RegistrationSent();
}

class VerificationEmailClicked extends Action {
  VerificationEmailClicked();
}