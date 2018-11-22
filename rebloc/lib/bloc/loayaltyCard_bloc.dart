import 'package:rebloc/rebloc.dart';
import 'package:hello_world/models/loyaltyCard.dart';
import 'package:hello_world/data/loyaltyCard_repository.dart';
import 'package:hello_world/models/app_state.dart';

class RefreshLoyaltyCardsAction extends Action {}

class RefreshedLoyaltyCardsAction extends Action {
  final List<LoyaltyCard> loyaltyCards;

  RefreshedLoyaltyCardsAction(this.loyaltyCards);
}

class AddedLoyaltyCardAction extends Action {
  final LoyaltyCard loyaltyCard;

  AddedLoyaltyCardAction(this.loyaltyCard);
}

class RefreshLoyaltyCardFailedAction extends Action {}

class AddedLoyaltyCardFailedAction extends Action {}

class LoyaltyCardBloc extends SimpleBloc<AppState> {
  LoyaltyCardRepository repository;

  LoyaltyCardBloc() {
    this.repository = LoyaltyCardRepository();
  }

  Action _refreshLoyaltyCards(DispatchFunction dispatcher, AppState state, RefreshLoyaltyCardsAction action) {
    repository.loadLoyaltyCards().then((newList) {
      final action = RefreshedLoyaltyCardsAction(newList.toList());
      dispatcher(action);
    }).catchError((e, s) {
      dispatcher(RefreshLoyaltyCardFailedAction());
    });

    return action;
  }

  AppState _refreshedLoyaltyCards(AppState state, RefreshedLoyaltyCardsAction action) {
    return state.rebuild((b) {
      for(LoyaltyCard loyaltyCard in action.loyaltyCards) {
        b.loyaltyCards[loyaltyCard.cardId] = loyaltyCard;
      }
    });
  }

  AppState _addedLoyaltyCard(AppState state, AddedLoyaltyCardAction action) {
    return state.rebuild((b) {
      final LoyaltyCard loyaltyCard = action.loyaltyCard;
      b.loyaltyCards[loyaltyCard.cardId] = loyaltyCard;
    });
  }

  @override
  Action middleware(dispatcher, state, action) {
    if (action is RefreshLoyaltyCardsAction) {
      return _refreshLoyaltyCards(dispatcher, state, action);
    }

    return action;
  }

  @override
  AppState reducer(state, action) {
    if (action is RefreshedLoyaltyCardsAction) {
      return _refreshedLoyaltyCards(state, action);
    } else if (action is AddedLoyaltyCardAction) {
      return _addedLoyaltyCard(state, action);
    }

    return state;
  }
}