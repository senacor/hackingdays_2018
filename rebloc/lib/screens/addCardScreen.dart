import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:better_yunar/screens/loyaltyCard_list.dart';
import 'package:rebloc/rebloc.dart';
import 'package:better_yunar/utils/logger.dart';
import 'package:better_yunar/bloc/loayaltyCard_bloc.dart';
import 'package:better_yunar/utils/showError.dart';
import 'package:better_yunar/data/web_client.dart';
import 'dart:async';
import 'dart:convert';
import 'package:better_yunar/models/loyaltyProgram.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class AddCardScreen extends StatelessWidget {
  static final programsUrl =
      Uri.parse('https://api.dev1.thatisnomoon.io/loyalty/programs');

  static Future<List<LoyaltyProgram>> loadPrograms() async {
    var response = await WebClient.instance().get(programsUrl);
    if (response.statusCode != 200) {
      final msg = 'Failed to fetch programs, status: ${response.statusCode}';
      throw Exception(msg);
    }

    final res = jsonDecode(response.body)
        .map((program) => LoyaltyProgram(
              name: program['name'],
              id: program['id'],
            ))
        .toList();
    return List<LoyaltyProgram>.from(res);
  }

  List<Widget> _create(List<LoyaltyProgram> data, context, dispatcher) {
    return data
        .map((d) => InkWell(
            onTap: () => _scan(context, dispatcher, d.id),
            highlightColor: Colors.green,
            child: Card(
              child: ListTile(
                leading: Icon(Icons.credit_card),
                title: Text(d.name),
              ),
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: ViewModelSubscriber<AppState, LoyaltyCardListViewModel>(
            converter: (state) => LoyaltyCardListViewModel(state),
            builder: (context, dispatcher, viewModel) => Center(
                  child: FutureBuilder<List<LoyaltyProgram>>(
                    future: loadPrograms(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<LoyaltyProgram>> snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _create(snapshot.data, context, dispatcher),
                      );
                    },
                  ),
                )));
  }

  Future _scan(programId, context, dispatcher) async {
    try {
      String cardNumber = await BarcodeScanner.scan();
      final card = await WebClient.instance().addLoyaltyCard(cardNumber, programId);
      dispatcher(AddedLoyaltyCardAction(card));
      Navigator.of(context).pushReplacementNamed('/mainScreen');
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showError(
            message: 'The user did not grant the camera permission!',
            scaffoldKey: _scaffoldKey);
      } else {
        showError(message: 'Unknown error: $e', scaffoldKey: _scaffoldKey);
      }
    } on FormatException {
      print(
          'User returned using the "back"-button before scanning anything. Result');
    } catch (e) {
      showError(message: 'Unknown error: $e', scaffoldKey: _scaffoldKey);
    }
  }
}
