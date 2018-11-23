import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:better_yunar/bloc/loayaltyCard_bloc.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:better_yunar/models/loyaltyCard.dart';

import 'package:better_yunar/screens/loyaltyCard_list.dart';
import 'package:rebloc/rebloc.dart';

void main() {
  testWidgets('Kunde wird mit freundlicher Ueberschrift begruesst', (WidgetTester tester) async {
    final mockStore = Store(initialState: AppState(), blocs: [LoyaltyCardBloc()]);
    await tester.pumpWidget(StoreProvider(store: mockStore, child: MaterialApp(home: LoyaltyCardListScreen())));

    expect(find.text('Alle Loyalty Karten Brudiii'), findsOneWidget);
  });

  testWidgets('Existierende Karten werden angezeigt', (WidgetTester tester) async {
    final LoyaltyCardBuilder loyaltyCardBuilder = LoyaltyCardBuilder();
    loyaltyCardBuilder.name='Payback';
    loyaltyCardBuilder.cardId='54321';
    loyaltyCardBuilder.cardNumber='12345';
    final LoyaltyCard loyaltyCard = loyaltyCardBuilder.build();
    final appStateBuilder = AppStateBuilder();
    final map = {};
    map['FF'] = loyaltyCard;
    appStateBuilder.loyaltyCards = MapBuilder(map);

    final mockStore = Store(initialState: appStateBuilder.build(), blocs: [LoyaltyCardBloc()]);
    await tester.pumpWidget(StoreProvider(store: mockStore, child: MaterialApp(home: LoyaltyCardListScreen())));

    expect(find.text('12345'), findsOneWidget);
  });
}
