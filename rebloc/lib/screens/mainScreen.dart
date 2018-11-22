import 'package:flutter/material.dart';
import 'package:hello_world/utils/logger.dart';

import 'loyaltyCard_list.dart';
import 'profileScreen.dart';

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Loyalty Cards', icon: Icons.payment),
  const Choice(title: 'Profile', icon: Icons.person),
];

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    log.info("build");
    return DefaultTabController(
        length: choices.length,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            isScrollable: false,
            labelColor: Color.fromARGB(255, 78, 72, 216),
            unselectedLabelColor: Color.fromARGB(255, 136, 138, 154),
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
                icon: Icon(choice.icon),
              );
            }).toList(),
          ),
          body: TabBarView(
            children: <Widget>[
              LoyaltyCardListScreen(),
              ProfileScreen(),
            ],
          )
      )
    );
  }

}
