import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:built_collection/built_collection.dart';
import 'package:better_yunar/utils/logger.dart';
import 'package:better_yunar/models/loyaltyCard.dart';
import 'package:better_yunar/models/user.dart';
import 'package:better_yunar/models/onboardingResponse.dart';
import 'package:better_yunar/models/serializers.dart';
import 'package:oauth2/oauth2.dart' as oauth;
import 'package:oauth2/oauth2.dart';


class WebClient {
  static var _instance;
  static const username = "ad0c4b33-594e-42f7-9b72-aae73e373231";
  static const password = "jR,vV,HGLVerJ`DVfhg^PFj)64Z7pn5dvw[.]Cge;fL>rmg|s#mVgVd%cMpQE\$Kw";
  final authorizationEndpoint = Uri.parse("https://api.dev1.thatisnomoon.io/auth/token");
  final loyaltyCardsUrl = Uri.parse("https://api.dev1.thatisnomoon.io/loyalty/cards");
  static const apiKey = "a524ae84-c799-4975-8ab1-9b07b5a28922";
  static const headers = { "x-api-key": apiKey, 'Content-type': 'application/json' };
  static const _requestTimeoutDuration = Duration(seconds: 10);
  static const maxAttempts = 3;

  var client;

  WebClient._internal();

  factory WebClient.instance() {
    if (_instance == null) {
      _instance = WebClient._internal();
    }
    return _instance;
  }

  Future<http.Response> get(Uri url, {Map<String, String> headers}) async {
    return _makeRequest(url, headers: headers);
  }

  Future<http.Response> _makeRequest(Uri url, {Map<String, String> headers}) async {
    if (client == null) {
      log.info("auth for request $url");
      client = await oauth.resourceOwnerPasswordGrant(
          authorizationEndpoint, username, password, identifier: "ambidexter",
          basicAuth: false,
          headers: { "x-api-key": apiKey });
    }

    int attempts = 0;
    http.Response response;

    if (headers == null) {
      headers = {};
    }

    headers.putIfAbsent("x-api-key", () => apiKey);

    do {
      attempts++;

      log.info("GET $url");
      response = await client.get(url, headers: headers)
        .timeout(_requestTimeoutDuration)
        .catchError((_) {
          String msg = 'Timed out requesting $url.';
          throw Exception(msg);
        });
    } while (response.statusCode == 500 && attempts < maxAttempts);

    return response;
  }

  Future<OnboardingResponse> onboard(String nickname) async {
    int attempts = 0;
    http.Response response;
    const String url = 'https://api.dev1.thatisnomoon.io/onboarding';

    do {
      attempts++;

      response = await http.post(url, body: json.encode({ 'nickname': username }), headers: headers)
        .timeout(_requestTimeoutDuration)
        .catchError((_) {
          String msg = 'Something went wrong with $url.';
          throw Exception(msg);
        });
    } while (response.statusCode == 500 && attempts < maxAttempts);

    if (response.statusCode != 201) {
      final msg = 'Failed to onboard user, status: ${response.statusCode}';
      throw Exception(msg);
    }

    log.info(response.body);

    final parsedJson = json.decode(response.body);
    final deserialized = serializers.deserialize(
      parsedJson,
      specifiedType: OnboardingResponse.serializationType,
    );

    return deserialized;
  }

  Future<BuiltList<LoyaltyCard>> fetchCards() async {
    final response = await _makeRequest(loyaltyCardsUrl);

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

  Future<Client> authenticated() async {
    if(client == null) {
      client = await oauth.resourceOwnerPasswordGrant(authorizationEndpoint, username, password, identifier: "ambidexter", basicAuth: false, headers: headers );
    }
    return client;
  }

  Future<LoyaltyCard> addLoyaltyCard(cardNumber) async {
    if(client == null) {
      client = await oauth.resourceOwnerPasswordGrant(authorizationEndpoint, username, password, identifier: "ambidexter", basicAuth: false, headers: headers );
    }

    var response = await client.post(loyaltyCardsUrl, headers: headers, body: _createBody(cardNumber));
    if(response.statusCode != 200) {
      throw 'Could not add card - Status: ${response.statusCode}';
    }

    final parsedJson = json.decode(response.body);
    final deserialized = serializers.deserialize(
      parsedJson,
      specifiedType: LoyaltyCard.serializationType,
    );

    return deserialized;
  }

  _createBody (cardNumber) {
    final body = <String, String>{};
    final paybackProgramId = "b2bde17c-2476-4507-b506-7a5b5d0552e3";
    body['loyaltyProgramId'] = paybackProgramId;
    body['cardNumber'] = cardNumber;
    return body;
  }
}