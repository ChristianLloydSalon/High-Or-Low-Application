import 'package:flutter/material.dart';
import 'package:high_or_low_application/AppPage.dart';
import 'package:high_or_low_application/CustomRoundButton.dart';
import 'package:high_or_low_application/CustomText.dart';
import 'package:high_or_low_application/GameLogic.dart';
import 'package:high_or_low_application/GamePage.dart';
import 'package:high_or_low_application/GameStatus.dart';

class GameOver extends StatelessWidget {
  final GameStatus status;

  const GameOver({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String message;
    late Color textColor;

    if (status == GameStatus.GAME_OVER) {
      message = 'GAME OVER!';
      textColor = Colors.red;
    } else if (status == GameStatus.VICTORY) {
      message = 'VICTORY!';
      textColor = Colors.amber;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: message,
              fontFamily: 'Roboto',
              color: textColor,
              heightRatio: 0.1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            CustomText(
              title: 'Score: ${GameLogic.score}',
              fontFamily: 'Roboto',
              color: textColor,
              heightRatio: 0.05,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            CustomRoundButton(
              icon: Icon(Icons.replay),
              color: Colors.blue,
              ratio: 0.15,
              function: () => {
                AppPage.goto(
                  page: GamePage.GAME_PAGE,
                  buildContext: context,
                  status: GameStatus.NONE,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
