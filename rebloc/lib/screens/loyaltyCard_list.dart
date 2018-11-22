import 'package:flutter/material.dart';
import 'package:hello_world/widgets/LoyaltyCard.dart';
import 'package:hello_world/bloc/loayaltyCard_bloc.dart';
import 'package:hello_world/models/app_state.dart';
import 'package:rebloc/rebloc.dart';
import 'package:hello_world/models/loyaltyCard.dart';
import 'package:hello_world/utils/logger.dart';

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
           Navigator.of(context).pop('new-loyalty-card');
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      )
    );
  }
}