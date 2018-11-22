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

typedef AchievementTapCallback = void Function(Achievement achievement);

class AchievementListViewModel {
  final List<Achievement> achievements;

  AchievementListViewModel(AppState state): this.achievements = state.achievements.values.toList();
}

class AchievementBoardScreen extends StatefulWidget {
  @override
  _AchievementBoardScreenState createState() => _AchievementBoardScreenState();
}

class _AchievementBoardScreenState extends State<AchievementBoardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achievements"),
        centerTitle: true,
      ),
      body: ViewModelSubscriber<AppState, AchievementListViewModel>(
          converter: (state) => AchievementListViewModel(state),
          builder: (context, dispatcher, viewModel) {
            if (viewModel.achievements == null || viewModel.achievements.length == 0) {
              dispatcher(RefreshAchievementsAction());
              return Center(
                  child: CircularProgressIndicator()
              );
            } else {
              return RefreshIndicator(
                  onRefresh: () {
                    log.info('ON REFRESH');
                    dispatcher(RefreshAchievementsAction());
                    return Future.value("");
                  },
                  child: buildAchievementGrid(viewModel.achievements)
              );
            }
          }
      )
    );
  }
}

Widget buildAchievementGrid(achievements) {
  return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 0.0,
      childAspectRatio: 1.2,
      children: _buildGridTileList(achievements)
  );
}

List<Widget> _buildGridTileList(List<Achievement> achievements) {
  return achievements.map<Widget>((Achievement achievement) {
    return AchievementGridItem(
        achievement: achievement,
        onTap: (Achievement achievement) {
          // TODO open detail
        }
    );
  }).toList();
}

class AchievementGridItem extends StatelessWidget {

  AchievementGridItem({
    Key key,
    @required this.achievement,
    @required this.onTap
  }) : assert(achievement != null),
        assert(onTap != null),
        super(key: key);

  final Achievement achievement;
  final AchievementTapCallback onTap; // User taps on the widget

  @override
  Widget build(BuildContext context) {
    var imageSrc = (achievement.gained
        ? achievement.previewImageUrl
        : imageBasePath() + "ungained_preview.png");

    var image = new ClipRRect(
        borderRadius: new BorderRadius.circular(10.0),
        child: Image.network(
            imageSrc,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
        ),
    );

    return GridTile(
        child: GestureDetector(
            onTap: () {
              onTap(achievement);
            },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        image,
                        Container(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                                achievement.title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16.0
                                )
                            )
                        )
                      ]
                  )
                ]
            )
        )
    );
  }
}
