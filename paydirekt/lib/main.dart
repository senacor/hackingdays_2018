import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pointycastle/digests/sha384.dart' as sha384;
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class Authentication {
  static String accessToken;

  static MapEntry<String, String> header() {
    if (accessToken == null) {
      return MapEntry(null, null);
    }

    return MapEntry("Authorization", "Bearer " + accessToken);
  }
}

class Account {
  static Map<String, dynamic> me;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextFormField usernameField = TextFormField(
    controller: TextEditingController(),
  );
  TextFormField passwordField = TextFormField(
    controller: TextEditingController(),
    obscureText: true,
  );
  String statusText = "";

  void login() async {
    String username = usernameField.controller.text;
    String password = passwordField.controller.text;

    // This is the accountweb-login credential header
    String credentials = "Basic YnYtYWNjb3VudC13ZWI6MVQ3MHB6UnJrUFNaN202WUpIdlpsdFlYN01YOWNiTlh0dzBEZVhrWXZuMA==";

    final encodedPassword = Base64Encoder.urlSafe().convert(sha384.SHA384Digest().process(Utf8Codec().encode(password)));

    setState(() => statusText = "Logging in...");
    print("Logging in.");

    final response = await http.post("https://www.paydirekt.de/api/accountuser/v1/token/obtain",
        headers: Map.fromEntries([
          MapEntry("Authorization", credentials),
          MapEntry("Content-Type", "application/json;charset=UTF-8"),
        ]),
        body: json.encode({"grantType": "password", "username": username, "password": encodedPassword}));

    print("Status: ${response.statusCode}");

    if (response.statusCode != 200) {
      setState(() => statusText = "Falsches Passwort");
    } else {
      Authentication.accessToken = json.decode(response.body)["access_token"];
      print("AccessToken: ${Authentication.accessToken}");

      loadMe();
    }
  }

  void loadMe() async {
    if (Authentication.accessToken == null) {
      return;
    }

    setState(() => statusText = "Loading data...");
    print("Loading self data.");

    var response = await http.get(
      "https://www.paydirekt.de/api/account/v1/accounts/me",
      headers: Map.fromEntries([Authentication.header(), MapEntry("Content-Type", "application/json;charset=UTF-8")]),
    );

    Account.me = json.decode(response.body);

    setState(() => statusText = "");
    print("Me : ${Account.me}");

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Meine Daten"),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.attach_money), onPressed: loadTransactions)
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            line("Nutzername", Account.me["username"]),
            line("Klarname", Account.me["naturalPerson"]["givenName"].toString() + " " + Account.me["naturalPerson"]["familyName"].toString()),
            line("Status", Account.me["accountStatus"]),
            line("Geburtstag", formatDate(Account.me["naturalPerson"]["dateOfBirth"])),
            line("Email", Account.me["emailAddress"]),
          ],
        ),
      );
    }));
  }

  String formatDate(input) => DateFormat("dd. MM. yyyy").format(new DateFormat("yyyy-MM-dd").parse(input));

  String formatDateTime(input) => DateFormat("dd. MM. yyyy - HH:mm:ss").format(DateTime.parse(input));

  void loadTransactions() async {
    if (Authentication.accessToken == null || Account.me == null) {
      return;
    }

    String transactionHistoryUrl = Account.me["_links"]["transaction-history"]["href"];

    print("Reading transaction history...");

    var response = await http.get(
      transactionHistoryUrl,
      headers: Map.fromEntries([
        Authentication.header(),
        MapEntry("Content-Type", "application/json;charset=UTF-8")
      ]),
    );

    print("${response.body}");

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      List<dynamic> transactions = json.decode(response.body)["_embedded"]["activityItems"];
      return Scaffold(
        appBar: AppBar(
          title: Text("Meine Transaktionen"),
        ),
        body: ListView.builder(
          itemBuilder: (context, i) {
            if (i.isOdd) {
              return Divider();
            }

            int index = i ~/ 2;

            if (index >= transactions.length) {
              return null;
            }


            return transaction(transactions.elementAt(index));
          },
        ),
      );
    }));
  }

  Widget transaction(Map<String, dynamic> data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        line("Empfänger", data["creditorName"]),
        line("Betrag", NumberFormat("####0.00").format(data["amount"]) + " €"),
        line("Datum", formatDateTime(data["creationTimestamp"])),
      ],
    );
  }

  Widget line(String title, Object content) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
      contentPadding: EdgeInsets.only(left: 12, right: 12),
      trailing: Padding(padding: EdgeInsets.only(left: 12, right: 12),child: Text(content?.toString())),
    );
  }

  Widget drawElement(dynamic input) {
    var padding = EdgeInsets.only(left: 32, bottom: 8);
    if (input is String || input is num || input is bool) {
      return Padding(
        padding: padding,
        child: Text(input.toString()),
      );
    }

    if (input is Iterable) {
      var childrenWidgets = <Widget>[];
      int i = 1;
      for (dynamic elem in input) {
        childrenWidgets.add(Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              i.toString() + ": ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            drawElement(elem),
          ],
        ));
        i++;
      }

      return Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: childrenWidgets,
          ));
    }

    if (input is Map<String, dynamic>) {
      var childrenWidgets = <Widget>[];
      for (String key in input.keys) {
        if (key.startsWith("_")) {
          continue;
        }
        childrenWidgets.add(Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              key,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            drawElement(input[key]),
          ],
        ));
      }

      return Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: childrenWidgets,
        ),
      );
    }

    return Divider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(children: <Widget>[
              Text(
                'Login',
                style: TextStyle(fontSize: 32, color: Colors.blueGrey),
              ),
              Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                Container(
                    margin: EdgeInsets.all(24),
                    child: Text(
                      'Username',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                Flexible(child: usernameField)
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                Container(
                    margin: EdgeInsets.all(24),
                    child: Text(
                      'Password',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                Flexible(child: passwordField)
              ]),
              Spacer(),
              Text("$statusText"),
              Spacer(),
              RaisedButton(
                  color: Colors.green,
                  child: Text(
                    "   Login!   ",
                  ),
                  onPressed: () {
                    login();
                  }),
              Spacer(),
            ])));
  }
}
