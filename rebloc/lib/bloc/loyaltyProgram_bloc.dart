import 'package:rebloc/rebloc.dart';

import 'package:better_yunar/models/app_state.dart';

import 'package:better_yunar/data/loyaltyProgram_repository.dart';

import 'package:better_yunar/models/loyaltyProgram.dart';

class RefreshLoyaltyProgramAction extends Action {}

class RefreshedLoyaltyProgramAction extends Action {
  final List<LoyaltyProgram> loyaltyPrograms;

  RefreshedLoyaltyProgramAction(this.loyaltyPrograms);
}

class RefreshLoyaltyCardFailedAction extends Action {}

class LoyaltyProgramBloc extends SimpleBloc<AppState> {
  LoyaltyProgramRepository repository;

  LoyaltyProgramBloc() {
    this.repository = LoyaltyProgramRepository();
  }

  Action _refreshLoyaltyPrograms(DispatchFunction dispatcher, AppState state,
      RefreshLoyaltyProgramAction action) {
    repository.loadPrograms().then((newList) {
      final action = RefreshedLoyaltyProgramAction(newList.toList());
      dispatcher(action);
    }).catchError((e, s) {
      dispatcher(RefreshLoyaltyCardFailedAction());
    });

    return action;
  }

@override
  Action middleware(dispatcher, state, action) {
    if (action is RefreshLoyaltyProgramAction) {
      return _refreshLoyaltyPrograms(dispatcher, state, action);
    }

    return action;
  }
}

var blocs = [
  LoyaltyProgramBloc(),
];
