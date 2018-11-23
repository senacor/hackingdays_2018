import 'package:built_collection/built_collection.dart';
import 'package:better_yunar/data/web_client.dart';
import 'package:better_yunar/models/loyaltyCard.dart';

class LoyaltyCardRepository {
  WebClient webClient;

  LoyaltyCardRepository(){
    webClient = WebClient.instance();
  }

  Future<BuiltList<LoyaltyCard>> loadLoyaltyCards() async {
    return await webClient.fetchCards();
  }

  Future<LoyaltyCard> addLoyaltyCard(cardNumber, programId) async {
    return await webClient.addLoyaltyCard(cardNumber, programId);
  }
}