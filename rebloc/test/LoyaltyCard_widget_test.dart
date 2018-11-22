// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:better_yunar/models/loyaltyCard.dart';
import 'package:better_yunar/widgets/LoyaltyCard.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final LoyaltyCardBuilder builder = LoyaltyCardBuilder();
    builder.name='Payback';
    builder.cardId='54321';
    builder.cardNumber='12345';
    final LoyaltyCard loyaltyCard = builder.build();

    await tester.pumpWidget(MaterialApp(home: LoyaltyCardWidget(loyaltyCard)));

    expect(find.text('Payback'), findsOneWidget);
    expect(find.text('12345'), findsOneWidget);
    expect(find.text('ZEIG MIR MEHR JUNGE'), findsOneWidget);
  });
}
