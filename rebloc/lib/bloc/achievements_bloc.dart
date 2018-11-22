import 'package:rebloc/rebloc.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:better_yunar/data/achievement_repository.dart';
import 'package:better_yunar/models/achievement.dart';
import 'package:better_yunar/utils/logger.dart';

class RefreshAchievementsAction extends Action {}

class RefreshedAchievementsAction extends Action {
  final List<Achievement> achievements;

  RefreshedAchievementsAction(this.achievements);
}

class AddedAchievementAction extends Action {
  final Achievement achievement;

  AddedAchievementAction(this.achievement);
}

class RefreshAchievementFailedAction extends Action {}

class AddedAchievementFailedAction extends Action {}

class AchievementBloc extends SimpleBloc<AppState> {
  AchievementRepository repository;

  AchievementBloc() {
    this.repository = AchievementRepository();
  }

  Action _refreshAchievements(DispatchFunction dispatcher, AppState state, RefreshAchievementsAction action) {
    repository.loadAchievements().then((newList) {
      final action = RefreshedAchievementsAction(newList.toList());
      dispatcher(action);
    }).catchError((e, s) {
      log.info("RefreshedAchievementsAction failed!", e, s);
      dispatcher(RefreshAchievementFailedAction());
    });

    return action;
  }

  AppState _refreshedAchievements(AppState state, RefreshedAchievementsAction action) {
    return state.rebuild((b) {
      for(Achievement achievement in action.achievements) {
        b.achievements[achievement.id] = achievement;
      }
    });
  }

  AppState _addedAchievement(AppState state, AddedAchievementAction action) {
    return state.rebuild((b) {
      final Achievement achievement = action.achievement;
      b.achievements[achievement.id] = achievement;
    });
  }

  @override
  Action middleware(dispatcher, state, action) {
    if (action is RefreshAchievementsAction) {
      return _refreshAchievements(dispatcher, state, action);
    }

    return action;
  }

  @override
  AppState reducer(state, action) {
    if (action is RefreshedAchievementsAction) {
      return _refreshedAchievements(state, action);
    } else if (action is AddedAchievementAction) {
      return _addedAchievement(state, action);
    }

    return state;
  }
}

var blocs = [
  AchievementBloc()
];