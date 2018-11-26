import 'package:better_yunar/bloc/achievements_bloc.dart';
import 'package:better_yunar/models/achievement.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:better_yunar/utils/dpi.dart';
import 'package:better_yunar/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';

String imageBasePath() {
  return "https://api.dev1.thatisnomoon.io/static/achievements/images/" +
      dpiName() +
      "/";
}

class AchievementDetails extends StatelessWidget {
  AchievementDetails({@required this.achievementId})
      : assert(achievementId != null),
        super();

  /// Builds the primary contents of the route.
  final String achievementId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dismissible(
          direction: DismissDirection.up,
          resizeDuration: null,
          key: ValueKey("213"),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.up) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: dialogContent(),
                  )))),
    );
  }

  FirstBuildDispatcher<AppState> dialogContent() {
    return FirstBuildDispatcher<AppState>(
        action: RefreshAchievementsAction(),
        child: ViewModelSubscriber<AppState, Achievement>(
            converter: (state) => state.achievements[achievementId],
            builder: (context, dispatcher, achievement) {
              if (achievement == null) {
                return Center(child: CircularProgressIndicator());
              } else {
                return RefreshIndicator(
                  onRefresh: () {
                    log.info('ON REFRESH');
                    dispatcher(RefreshAchievementsAction());
                    return Future.value("");
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      achivementImage(context, achievement),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                      ),
                      text(achievement.header, fontSize: 25),
                      text(achievement.title,
                          fontSize: 40, fontWeight: FontWeight.bold),
                      text(achievement.description),
                    ],
                  ),
                );
              }
            }));
  }

  Widget text(String text,
      {double fontSize = 20, FontWeight fontWeight = FontWeight.normal}) {
    return space(Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
            decoration: TextDecoration.none,
            color: Color.fromARGB(255, 80, 83, 107),
            fontWeight: fontWeight,
            fontFamily: 'Roboto',
            fontSize: fontSize)));
  }

  Stack achivementImage(BuildContext context, Achievement achievement) {
    var imageSrc = (achievement.gained
        ? achievement.previewImageUrl
        : imageBasePath() + "ungained_preview.png");

    var backButton = RaisedButton(
        color: Color.fromARGB(255, 244, 245, 247),
        child: Text("X"),
        shape: CircleBorder(
            side: BorderSide(width: 10.0, style: BorderStyle.none)),
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          Navigator.of(context).pop();
        });

    return Stack(
      children: <Widget>[
        Image.network(
          imageSrc,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
        Positioned(
          top: 15.0,
          right: 0.0,
          child: backButton,
        ),
      ],
    );
  }
}

Widget space(Widget w) => new Container(
      padding: const EdgeInsets.all(5.0),
      child: w,
    );
