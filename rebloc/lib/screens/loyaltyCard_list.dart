import 'package:flutter/material.dart';
import 'package:better_yunar/widgets/LoyaltyCard.dart';
import 'package:better_yunar/bloc/loayaltyCard_bloc.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:rebloc/rebloc.dart';
import 'package:better_yunar/models/loyaltyCard.dart';
import 'package:better_yunar/utils/logger.dart';
import 'package:better_yunar/screens/addCardScreen.dart';

class LoyaltyCardListViewModel {
  final List<LoyaltyCard> loyaltyCards;

  LoyaltyCardListViewModel(AppState state): this.loyaltyCards = state.loyaltyCards.values.toList();

}

class LoyaltyCardListScreen extends StatefulWidget {
  @override
  _LoyaltyCardListScreenState createState() => _LoyaltyCardListScreenState();
}

class _LoyaltyCardListScreenState extends State<LoyaltyCardListScreen> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    log.info("build");
    return Scaffold(
      appBar: AppBar(
        title: Text('Alle Loyalty Karten Brudiii'),
      ),
      body: ViewModelSubscriber<AppState, LoyaltyCardListViewModel>(
        converter: (state) => LoyaltyCardListViewModel(state),
        builder: (context, dispatcher, viewModel) {
          return RefreshIndicator(
            onRefresh: () {
              log.info('ON REFRESH');
              dispatcher(RefreshLoyaltyCardsAction());
              return Future.delayed(Duration(seconds: 2), () {});
            },
            child: ListView.builder(
              itemCount: viewModel.loyaltyCards.length,
              itemBuilder: (context, i) {
                return LoyaltyCardWidget(viewModel.loyaltyCards[i]);
              },
              controller: controller,
              physics: PageScrollPhysics()
            )
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCardScreen()),
                );
           Navigator.of(context).pushReplacementNamed('/addLoyaltyCard');
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      )
    );
  }
}