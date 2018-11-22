import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:built_collection/built_collection.dart';
import 'package:hello_world/utils/logger.dart';
import 'package:hello_world/models/loyaltyCard.dart';
import 'dart:convert';
import 'package:hello_world/models/serializers.dart';
import 'package:oauth2/oauth2.dart' as oauth;


class WebClient {
  static const username = "ad0c4b33-594e-42f7-9b72-aae73e373231";
  static const password = "jR,vV,HGLVerJ`DVfhg^PFj)64Z7pn5dvw[.]Cge;fL>rmg|s#mVgVd%cMpQE\$Kw";
  final authorizationEndpoint = Uri.parse("https://api.dev1.thatisnomoon.io/auth/token");
  final loyaltyCardsUrl = Uri.parse("https://api.dev1.thatisnomoon.io/loyalty/cards");
  static const headers = { "x-api-key": "a524ae84-c799-4975-8ab1-9b07b5a28922" };
  static const _requestTimeoutDuration = Duration(seconds: 10);
  static const maxAttempts = 3;
  var client;

  WebClient();

  Future<http.Response> _makeRequest(String url) async {
    if(client == null) {
      client = await oauth.resourceOwnerPasswordGrant(authorizationEndpoint, username, password, identifier: "ambidexter", basicAuth: false, headers: headers );
    }

    int attempts = 0;
    http.Response response;

    do {
      attempts++;

      response = await client.get(loyaltyCardsUrl, headers: { "x-api-key": "a524ae84-c799-4975-8ab1-9b07b5a28922" })
        .timeout(_requestTimeoutDuration)
        .catchError((_) {
          String msg = 'Timed out requesting $url.';
          throw Exception(msg);
        });
    } while (response.statusCode == 500 && attempts < maxAttempts);

    return response;
  }

  Future<BuiltList<LoyaltyCard>> fetchCards() async {
    final response = await _makeRequest('https://api.dev1.thatisnomoon.io/loyalty/cards');

    if (response.statusCode != 200) {
      final msg = 'Failed to fetch cards, status: ${response.statusCode}';
      throw Exception(msg);
    }

    log.info(response.body);

    final parsedJson = json.decode(response.body);
    final deserialized = serializers.deserialize(
      parsedJson,
      specifiedType: LoyaltyCard.listSerializationType,
    );

    return deserialized;
  }
}