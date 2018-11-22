import 'package:flutter/material.dart';
import 'package:hello_world/utils/logger.dart';

import 'achievementBoard.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    log.info("build");
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Achievements'),
              onPressed: () {
                // Navigate to achievement board when tapped!
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AchievementBoardScreen()),
                );
              },
            ),
          ],
        ),
    );
  }
}
