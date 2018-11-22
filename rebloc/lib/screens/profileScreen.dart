import 'package:flutter/material.dart';
import 'package:better_yunar/utils/logger.dart';

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
