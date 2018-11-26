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
import 'package:better_yunar/models/loyaltyProgram.dart';
import 'package:better_yunar/bloc/loyaltyProgram_bloc.dart';
import 'package:better_yunar/data/loyaltyProgram_repository.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class LoyaltyProgramListViewModel {}

class AddCardScreen extends StatelessWidget {
  final LoyaltyProgramRepository repository = LoyaltyProgramRepository();

  int _getColorHexFromStr(String name, String colorStr) {
    if (colorStr == null) {
      log.warning('No text color for $name');
      return 0;
    }
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  List<Widget> _create(List<LoyaltyProgram> data, context, dispatcher) {
    return data
        .map((d) => InkWell(
            onTap: () => _scan(context, dispatcher, d.programId),
            highlightColor: Colors.green,
            child: Card(
              child: ListTile(
                leading: Icon(
                  Icons.credit_card,
                  color: Color(_getColorHexFromStr(d.name, d.textColor)),
                ),
                title: Text(
                  d.name,
                  style: TextStyle(
                      color: Color(_getColorHexFromStr(d.name, d.textColor))),
                ),
              ),
              color: Color(_getColorHexFromStr(d.name, d.backgroundColor)),
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Programs'),
      ),
      body: ViewModelSubscriber<AppState, LoyaltyProgramListViewModel>(
        converter: (_) => LoyaltyProgramListViewModel(),
        builder: (context, dispatcher, viewModel) => RefreshIndicator(
              onRefresh: () {
                dispatcher(RefreshLoyaltyProgramAction());
                return Future.delayed(Duration(seconds: 1), () {});
              },
              child: Center(
                child: FutureBuilder<List<LoyaltyProgram>>(
                  future: repository.loadPrograms(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<LoyaltyProgram>> snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    return ListView(
                      children: _create(snapshot.data, context, dispatcher),
                    );
                  },
                ),
              ),
            ),
      ),
    );
  }

  Future _scan(context, dispatcher, programId) async {
    log.info('ProgramId: $programId');
    try {
      String cardNumber = await BarcodeScanner.scan();
      final card =
          await WebClient.instance().addLoyaltyCard(cardNumber, programId);
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
