import 'package:flutter/material.dart';
import 'package:high_or_low_application/GamePage.dart';
import 'package:high_or_low_application/GameStatus.dart';
import 'package:high_or_low_application/GamingPage.dart';
import 'package:high_or_low_application/GameOver.dart';
import 'package:high_or_low_application/main.dart';

class AppPage {
  static void goto({
    required GamePage page,
    required BuildContext buildContext,
    required GameStatus status,
  }) {
    if (status != GameStatus.NONE) {
      Navigator.push(
        buildContext,
        MaterialPageRoute(
          builder: (buildContext) => GameOver(status: status),
        ),
      );
    } else {
      Navigator.push(
        buildContext,
        MaterialPageRoute(
          builder: (buildContext) =>
              (page == GamePage.HOME_PAGE) ? HomePage() : GamingPage(),
        ),
      );
    }
  }
}
