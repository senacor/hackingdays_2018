import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:better_yunar/models/app_state.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnboardingScreenState();
  }
}

class _OnboardingScreenViewModel {
  final bool isRequestRunning;
  final String errorMessage;

  _OnboardingScreenViewModel({this.isRequestRunning, this.errorMessage});
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isTyping;
  FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _isTyping = false;
    _focus.addListener(onFocusChanged);
  }

  void onFocusChanged() {
    setState(() {
      _isTyping = !_isTyping;
    });
  }

  void onSubmitted(_) {
    // widget.register(_username);
  }

  void onButtonPressed() {
    //  widget.register(_username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelSubscriber<AppState, _OnboardingScreenViewModel>(
      converter: (state) => _OnboardingScreenViewModel(
          errorMessage: state.onboarding.onboardingRequestErrorMessage,
          isRequestRunning: state.onboarding.isOnboardingRequestRunning),
      builder: (context, dispatcher, viewModel) => GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              height: 5000,
              child: Column(
                children: <Widget>[
                  _YunarHeader(isCollapsed: _isTyping),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
                    alignment: Alignment(-1, -1),
                    child: Text(
                      'Wie darf ich dich nennen?',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: TextField(
                      onSubmitted: onSubmitted,
                      focusNode: _focus,
                      enabled: !viewModel.isRequestRunning,
                      decoration:
                          InputDecoration(errorText: viewModel.errorMessage),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: ButtonTheme(
                          minWidth: 230,
                          height: 60,
                          child: RaisedButton(
                            onPressed:
                                viewModel.isRequestRunning ? null : onButtonPressed,
                            child: viewModel.isRequestRunning
                                ? CircularProgressIndicator()
                                : Text(
                                    'Zustimmen & Registrieren',
                                    style: TextStyle(color: Colors.white),
                                  ),
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                          )))
                ],
              ),
            ),
          ),
    ));
  }
}

class _YunarHeader extends StatelessWidget {
  final bool isCollapsed;

  _YunarHeader({this.isCollapsed});

  Widget build(BuildContext context) {
    var firstChild = Container(
      height: 100,
      width: 1000,
      color: Theme.of(context).backgroundColor,
      child: Container(
        child: Image.asset(
          'assets/yunarZwinker.png',
          width: 30,
        ),
        margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
      ),
    );

    var secondChild = Container(
        height: 260,
        width: 1000,
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/yunarZwinker.png',
                width: 80,
              ),
              margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
            ),
            Container(
              child: Text(
                'SCHÖN, DICH ZU SEHEN!',
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: Theme.of(context).textTheme.display1,
              ),
              margin: EdgeInsets.fromLTRB(10, 25, 10, 10),
              width: 230,
            )
          ],
        ));
    return AnimatedCrossFade(
        firstChild: firstChild,
        secondChild: secondChild,
        duration: Duration(milliseconds: 200),
        crossFadeState:
            isCollapsed ? CrossFadeState.showFirst : CrossFadeState.showSecond);
  }
}
