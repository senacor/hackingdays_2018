import 'package:better_yunar/data/web_client.dart';
import 'package:better_yunar/models/loyaltyProgram.dart';
import 'dart:convert';

class LoyaltyProgramRepository {
  WebClient webClient;

  LoyaltyProgramRepository(){
    webClient = WebClient.instance();
  }

  static final programsUrl =
      Uri.parse('https://api.dev1.thatisnomoon.io/loyalty/programs');
  
  Future<List<LoyaltyProgram>> loadPrograms() async {
    final response = await webClient.get(programsUrl);
    if (response.statusCode != 200) {
      final msg = 'Failed to fetch programs, status: ${response.statusCode}';
      throw Exception(msg);
    }

    final res = jsonDecode(response.body)
        .map((program) => LoyaltyProgram(
              name: program['name'],
              programId: program['id'],
              backgroundColor: program['brandBackgroundColor'],
              textColor: program['brandTextColor'],
            ))
        .toList();
    return List<LoyaltyProgram>.from(res);
  }
}