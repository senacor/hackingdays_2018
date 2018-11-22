import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/models/app_state.dart';
import 'package:hello_world/screens/loyaltyCard_list.dart';
import 'package:rebloc/rebloc.dart';
import '../utils/showError.dart';
import 'package:hello_world/data/web_client.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class AddCardScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text('QR Code Scanner'),
        ),
        body: ViewModelSubscriber<AppState, LoyaltyCardListViewModel>(
          converter: (state) => LoyaltyCardListViewModel(state),
          builder: (context, dispatcher, viewModel) =>
            Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        splashColor: Colors.blueGrey,
                        onPressed: () => _scan(context, dispatcher),
                        child: const Text('Scan Barcode / QR Code')
                    ),
                  ),
                ],
              ),
            )
        )
      );
    }

  Future _scan(context, dispatcher) async {
    try {
      String cardNumber = await BarcodeScanner.scan();
      final card = await WebClient.instance().addLoyaltyCard(cardNumber);
      dispatcher(AddedLoyaltyCardAction(card));
      Navigator.of(context).pushReplacementNamed('/mainScreen');
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
          showError(message: 'The user did not grant the camera permission!', scaffoldKey: _scaffoldKey);
      } else {
        showError(message: 'Unknown error: $e', scaffoldKey: _scaffoldKey);
      }
    } on FormatException{
      print('User returned using the "back"-button before scanning anything. Result');
    } catch (e) {
      showError(message: 'Unknown error: $e', scaffoldKey: _scaffoldKey);
    }
  }
}