import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:built_collection/built_collection.dart';
import 'package:better_yunar/utils/logger.dart';
import 'package:better_yunar/models/loyaltyCard.dart';
import 'package:better_yunar/models/user.dart';
import 'package:better_yunar/models/onboardingResponse.dart';
import 'package:better_yunar/models/serializers.dart';
import 'package:better_yunar/models/password.dart';
import 'package:oauth2/oauth2.dart' as oauth;


class WebClient {
  static var _instance;
  final authorizationEndpoint = Uri.parse("https://api.dev1.thatisnomoon.io/auth/token");
  final loyaltyCardsUrl = Uri.parse("https://api.dev1.thatisnomoon.io/loyalty/cards");
  static const apiKey = "a524ae84-c799-4975-8ab1-9b07b5a28922";
  static const headers = { "x-api-key": apiKey, 'Content-type': 'application/json' };
  static const _requestTimeoutDuration = Duration(seconds: 10);
  static const maxAttempts = 3;

  var client;
  String userId;

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

  void initOauth(username, password, userId) async {
    this.userId = userId;

    client = await oauth.resourceOwnerPasswordGrant(
      authorizationEndpoint,
      username,
      password,
      identifier: "ambidexter",
      basicAuth: false,
      customHeaders: { "x-api-key": apiKey }
    );
  }

  Future<http.Response> _makeRequest(Uri url, {Map<String, String> headers}) async {
    if (client == null) {
      throw Exception('Run .initOuath before');
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

      response = await http.post(url, body: json.encode({ 'nickname': nickname }), headers: headers)
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

  Future<LoyaltyCard> addLoyaltyCard(cardNumber) async {
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

  Future<Password> register(mailaddress, password) async {
    final registrationUrl = Uri.parse("https://api.dev1.thatisnomoon.io/users/$userId/registration");

    var response = await client.post(registrationUrl, body: json.encode({"mailAddress": mailaddress, "password": password}), headers: headers);

    if(response.statusCode != 204) {
      throw 'Could not register user - Status: ${response.statusCode}';
    }

    final parsedJson = json.decode(response.body);
    final deserialized = serializers.deserialize(
      parsedJson,
      specifiedType: Password.serializationType,
    );

    return deserialized;
  }

  Future<User> getMe() async {
    final getMeUrl = Uri.parse("https://api.dev1.thatisnomoon.io/users/me");

    var response = await client.get(getMeUrl, headers: headers);

    if(response.statusCode != 200) {
      throw 'Could not register user - Status: ${response.statusCode}';
    }

    final parsedJson = json.decode(response.body);
    final deserialized = serializers.deserialize(
      parsedJson['user'],
      specifiedType: User.serializationType,
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