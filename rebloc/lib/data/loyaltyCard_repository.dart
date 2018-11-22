import 'package:built_collection/built_collection.dart';
import 'package:hello_world/data/web_client.dart';
import 'package:hello_world/models/loyaltyCard.dart';

class LoyaltyCardRepository {
  WebClient webClient;

  LoyaltyCardRepository(){
    webClient = WebClient();
  }

  Future<BuiltList<LoyaltyCard>> loadLoyaltyCards() async {
    return await webClient.fetchCards();
  }
}