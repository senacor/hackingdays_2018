import 'package:flutter/material.dart';

const imageBasePath = "assets/images/achievements/";

class Achievement {
  Achievement({
    this.achievementTypeId,
    this.gained,
    this.gainedCount = 0,
    this.title,
  });

  final String achievementTypeId;
  final bool gained;
  final int gainedCount;
  final String title;

  Achievement.fromJson(Map<String, dynamic> json)
      : achievementTypeId = json['achievementTypeId'],
        gained = json['gained'],
        gainedCount = json['gainedCount'],
        title = json['title'];
}

typedef AchievementTapCallback = void Function(Achievement achievement);

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }
}

class AchievementBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achievements"),
        centerTitle: true,
      ),
      body: Center(
        child: buildAchievementGrid(),
      ),
    );
  }
}

Widget buildAchievementGrid() {
  return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 0.0,
      childAspectRatio: 1.4,
      children: _buildGridTileList(List<Achievement>.from(achievements.map((e) => Achievement.fromJson(e)))));
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

    var imageSrc = imageBasePath + (achievement.gained
        ? achievement.achievementTypeId + "_preview.jpg"
        : "ungained_preview.png");

    var image = new ClipRRect(
        borderRadius: new BorderRadius.circular(10.0),
          child: Image.asset(
            imageSrc,
            fit: BoxFit.cover,
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

// TODO: load from state
List achievements = [
  {
    "achievementTypeId": "3cd40e35-5a25-42a7-9ebb-9256fe072262",
    "userId": "28ad8a76-f86a-498e-9853-6d4878829905",
    "gained": true,
    "title": "Ready to roll",
    "description": "Add your first loyalty card and you're ready to roll!",
    "header": "Almost...",
    "actions": [
      {
        "name": "Let's do it",
        "link": "ambidexter://thatisnomoon.io/wallet"
      }
    ],
    "imageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/3cd40e35-5a25-42a7-9ebb-9256fe072262.jpg",
    "previewImageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/3cd40e35-5a25-42a7-9ebb-9256fe072262_preview.jpg",
    "id": "3cd40e35-5a25-42a7-9ebb-9256fe072262-28ad8a76-f86a-498e-9853-6d4878829905"
  },
  {
    "achievementTypeId": "36bc4a44-4830-488b-9e13-1490d57ac82f",
    "userId": "28ad8a76-f86a-498e-9853-6d4878829905",
    "gained": false,
    "title": "Brilliant",
    "description": "With five added cards, you can score endlessly!",
    "header": "Show us that you are...",
    "actions": [
      {
        "name": "Let's do it",
        "link": "ambidexter://thatisnomoon.io/wallet"
      }
    ],
    "imageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/36bc4a44-4830-488b-9e13-1490d57ac82f.jpg",
    "previewImageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/36bc4a44-4830-488b-9e13-1490d57ac82f_preview.jpg",
    "id": "36bc4a44-4830-488b-9e13-1490d57ac82f-28ad8a76-f86a-498e-9853-6d4878829905"
  },
  {
    "achievementTypeId": "b4ec222a-36c6-4c49-802d-23b32f3b2951",
    "userId": "28ad8a76-f86a-498e-9853-6d4878829905",
    "gained": true,
    "title": "Enlightened",
    "description": "Connect your first bonus program with the app and you'll instantly see your point balance.",
    "header": "The next level...",
    "actions": [
      {
        "name": "Let's do it",
        "link": "ambidexter://thatisnomoon.io/wallet"
      }
    ],
    "imageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/b4ec222a-36c6-4c49-802d-23b32f3b2951.jpg",
    "previewImageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/b4ec222a-36c6-4c49-802d-23b32f3b2951_preview.jpg",
    "id": "b4ec222a-36c6-4c49-802d-23b32f3b2951-28ad8a76-f86a-498e-9853-6d4878829905"
  },
  {
    "achievementTypeId": "fea07be1-1b32-4c89-9bb8-e6974f9e663d",
    "userId": "28ad8a76-f86a-498e-9853-6d4878829905",
    "gained": true,
    "gainedCount": 0,
    "title": "Loyalty Checker",
    "description": "You need 25 loyalty points between Monday and Sunday for your registered bonus programmes.",
    "header": "First stage...",
    "actions": [
      {
        "name": "Let's do it",
        "link": "ambidexter://thatisnomoon.io/wallet"
      }
    ],
    "imageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/fea07be1-1b32-4c89-9bb8-e6974f9e663d.jpg",
    "previewImageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/fea07be1-1b32-4c89-9bb8-e6974f9e663d_preview.jpg",
    "id": "fea07be1-1b32-4c89-9bb8-e6974f9e663d-28ad8a76-f86a-498e-9853-6d4878829905"
  },
  {
    "achievementTypeId": "4caf4a61-39b3-463b-ad9f-d059c21fafc4",
    "userId": "28ad8a76-f86a-498e-9853-6d4878829905",
    "gained": false,
    "gainedCount": 0,
    "title": "Loyalty Fox",
    "description": "You need 100 loyalty points between Monday and Sunday for your registered bonus programmes.",
    "header": "Next stage...",
    "actions": [
      {
        "name": "Let's do it",
        "link": "ambidexter://thatisnomoon.io/wallet"
      }
    ],
    "imageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/4caf4a61-39b3-463b-ad9f-d059c21fafc4.jpg",
    "previewImageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/4caf4a61-39b3-463b-ad9f-d059c21fafc4_preview.jpg",
    "id": "4caf4a61-39b3-463b-ad9f-d059c21fafc4-28ad8a76-f86a-498e-9853-6d4878829905"
  },
  {
    "achievementTypeId": "88265884-7b69-42b6-ad9a-e50fdd0c8515",
    "userId": "28ad8a76-f86a-498e-9853-6d4878829905",
    "gained": true,
    "gainedCount": 0,
    "title": "Loyalty Pro",
    "description": "Get yourself 250 loyalty points for your registered bonus programmes between Monday and Sunday.",
    "header": "Soon you'll be a...",
    "actions": [
      {
        "name": "Let's do it",
        "link": "ambidexter://thatisnomoon.io/wallet"
      }
    ],
    "imageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/88265884-7b69-42b6-ad9a-e50fdd0c8515.jpg",
    "previewImageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/88265884-7b69-42b6-ad9a-e50fdd0c8515_preview.jpg",
    "id": "88265884-7b69-42b6-ad9a-e50fdd0c8515-28ad8a76-f86a-498e-9853-6d4878829905"
  },
  {
    "achievementTypeId": "927404e9-f220-4c95-8a04-815da406c2dd",
    "userId": "28ad8a76-f86a-498e-9853-6d4878829905",
    "gained": true,
    "gainedCount": 0,
    "title": "Loyalty Hero",
    "description": "You need 500 loyalty points between Monday and Sunday for your registered bonus programmes.",
    "header": "You can be a...",
    "actions": [
      {
        "name": "Let's do it",
        "link": "ambidexter://thatisnomoon.io/wallet"
      }
    ],
    "imageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/927404e9-f220-4c95-8a04-815da406c2dd.jpg",
    "previewImageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/927404e9-f220-4c95-8a04-815da406c2dd_preview.jpg",
    "id": "927404e9-f220-4c95-8a04-815da406c2dd-28ad8a76-f86a-498e-9853-6d4878829905"
  },
  {
    "achievementTypeId": "c278d373-8279-4b78-8d35-efa6cfb28366",
    "userId": "28ad8a76-f86a-498e-9853-6d4878829905",
    "gained": false,
    "gainedCount": 0,
    "title": "Loyalty Genius",
    "description": "You need 1000 loyalty points between Monday and Sunday for your registered bonus programmes.",
    "header": "Become a real...",
    "actions": [
      {
        "name": "Let's do it",
        "link": "ambidexter://thatisnomoon.io/wallet"
      }
    ],
    "imageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/c278d373-8279-4b78-8d35-efa6cfb28366.jpg",
    "previewImageUrl": "https://api.dev1.thatisnomoon.io/static/achievements/images/xxxhdpi/c278d373-8279-4b78-8d35-efa6cfb28366_preview.jpg",
    "id": "c278d373-8279-4b78-8d35-efa6cfb28366-28ad8a76-f86a-498e-9853-6d4878829905"
  }
];