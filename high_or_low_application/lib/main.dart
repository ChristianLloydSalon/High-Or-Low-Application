import 'package:flutter/material.dart';
import 'package:high_or_low_application/AppPage.dart';
import 'package:high_or_low_application/CustomRoundButton.dart';
import 'package:high_or_low_application/CustomText.dart';
import 'package:high_or_low_application/GameLogic.dart';
import 'package:high_or_low_application/GamePage.dart';
import 'package:high_or_low_application/GameStatus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HIGH OR LOW',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameLogic.loadImageNames();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: 'HIGH',
              fontFamily: 'Odibee Sans',
              color: Colors.red,
              heightRatio: 0.2,
            ),
            CustomText(
              title: 'OR',
              fontFamily: 'Odibee Sans',
              color: Colors.white,
              heightRatio: 0.2,
            ),
            CustomText(
              title: 'LOW',
              fontFamily: 'Odibee Sans',
              color: Colors.blue,
              heightRatio: 0.2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            CustomRoundButton(
              icon: Icon(Icons.play_arrow),
              color: Colors.green,
              ratio: 0.16,
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
