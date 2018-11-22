import 'package:flutter/material.dart';
import 'package:hello_world/utils/logger.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    log.info("build");
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
    );
  }
}
