import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/models/loyaltyCard.dart';

class LoyaltyCardWidget extends StatelessWidget {
  final LoyaltyCard loyaltyCard;

  const LoyaltyCardWidget(
    this.loyaltyCard
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(loyaltyCard.name),
            subtitle: Text('Das ist eine Loyalty Programm Karte'),
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('ZEIG MIR MEHR JUNGE'),
                  onPressed: () { /* ... */ },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}