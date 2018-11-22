import 'dart:async';
import 'dart:convert';
import 'package:built_collection/built_collection.dart';
import 'package:better_yunar/data/web_client.dart';
import 'package:better_yunar/utils/logger.dart';
import 'package:better_yunar/models/serializers.dart';
import 'package:better_yunar/models/achievement.dart';

class AchievementRepository {

  var achievementsUrl = Uri.parse('https://api.dev1.thatisnomoon.io/achievements');

  WebClient webClient;

  AchievementRepository() {
    webClient = WebClient.instance();
  }

  Future<BuiltList<Achievement>> loadAchievements() async {
    var response = await webClient.get(achievementsUrl);

    if (response.statusCode != 200) {
      final msg = 'Failed to fetch cards, status: ${response.statusCode}';
      throw Exception(msg);
    }

    log.info(response.body);

    return serializers.deserialize(
      json.decode(response.body)['achievements'],
      specifiedType: Achievement.listSerializationType,
    );
  }
}
