import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:high_or_low_application/AppPage.dart';
import 'package:high_or_low_application/CustomRoundButton.dart';
import 'package:high_or_low_application/CustomText.dart';
import 'package:high_or_low_application/GameLogic.dart';
import 'package:high_or_low_application/GamePage.dart';
import 'package:high_or_low_application/GameStatus.dart';

class GamingPage extends StatefulWidget {
  const GamingPage({Key? key}) : super(key: key);

  @override
  _GamingPageState createState() => _GamingPageState();
}

class _GamingPageState extends State<GamingPage> {
  @override
  Widget build(BuildContext context) {
    GameLogic.reset();
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              bool isPortrait = orientation == Orientation.portrait;

              if (constraints.maxWidth > 600 || !isPortrait) {
                return _WebLayout();
              } else {
                return _MobileLayout();
              }
            },
          );
        },
      ),
    );
  }
}

// Mobile Layout
class _MobileLayout extends StatefulWidget {
  const _MobileLayout({Key? key}) : super(key: key);

  @override
  __MobileLayoutState createState() => __MobileLayoutState();
}

class __MobileLayoutState extends State<_MobileLayout> {
  GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  void guess(bool highOrEqual, BuildContext context) {
    setState(() {
      GameLogic.game(highOrEqual);

      if (GameLogic.gameOver) {
        AppPage.goto(
          page: GamePage.GAME_OVER,
          buildContext: context,
          status: GameStatus.GAME_OVER,
        );
      } else if (GameLogic.victory) {
        AppPage.goto(
          page: GamePage.GAME_OVER,
          buildContext: context,
          status: GameStatus.VICTORY,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;

    double halfWidth = appWidth / 2.0;
    double halfHeight = appHeight / 2.0;

    // margin for the guess board
    double margin =
        (appWidth < appHeight) ? halfWidth * 0.07 : halfHeight * 0.04;

    // card width
    double cardWidth = (halfWidth - margin) * 0.27;

    // card height
    double cardHeight = (halfHeight - margin) * 0.447;

    return Center(
      child: Column(
        children: [
          CustomText(
            title: 'SCORE: ${GameLogic.score}',
            fontFamily: 'Digital-7 Regular',
            color: Colors.white,
            heightRatio: 0.08,
          ),
          Container(
            width: appWidth - margin,
            height: appHeight * 0.32,
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
              color: Colors.green[900],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              runAlignment: WrapAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < GameLogic.guesses.length; i++)
                  Image.asset(
                    'images/${GameLogic.guesses.elementAt(i)}',
                    width: cardWidth,
                    height: cardHeight,
                  ),
              ],
            ),
          ),
          Container(
            width: appWidth - margin - margin,
            height: (appHeight * 0.5) - margin,
            decoration: BoxDecoration(
              color: Colors.green[900],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/${GameLogic.currentCard}',
                      width: cardWidth,
                      height: cardHeight,
                    ),
                    SizedBox(
                      width: appWidth * 0.05,
                    ),
                    FlipCard(
                      onFlipDone: (bool done) {
                        if (!done) {
                          _cardKey.currentState!.toggleCard();
                        }
                      },
                      speed: 1000,
                      key: _cardKey,
                      flipOnTouch: false,
                      direction: FlipDirection.HORIZONTAL, // default
                      front: Container(
                        child: Image.asset(
                          'images/FD.jpg',
                          width: cardWidth,
                          height: cardHeight,
                        ),
                      ),
                      back: Container(
                        child: Image.asset(
                          'images/${GameLogic.currentCard}',
                          width: cardWidth,
                          height: cardHeight,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: appHeight * 0.05,
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceEvenly,
                  children: [
                    CustomRoundButton(
                      icon: Icon(Icons.arrow_upward),
                      color: Colors.red,
                      ratio: 0.1,
                      function: () {
                        guess(true, context);
                        _cardKey.currentState!.toggleCard();
                      },
                    ),
                    SizedBox(
                      width: appWidth * 0.1,
                    ),
                    CustomRoundButton(
                      icon: Icon(Icons.arrow_downward),
                      color: Colors.blue,
                      ratio: 0.1,
                      function: () {
                        guess(false, context);
                        _cardKey.currentState!.toggleCard();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Web Layout
class _WebLayout extends StatefulWidget {
  const _WebLayout({Key? key}) : super(key: key);

  @override
  __WebLayoutState createState() => __WebLayoutState();
}

class __WebLayoutState extends State<_WebLayout> {
  GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  void guess(bool highOrEqual, BuildContext context) {
    setState(() {
      GameLogic.game(highOrEqual);

      if (GameLogic.gameOver) {
        AppPage.goto(
          page: GamePage.GAME_OVER,
          buildContext: context,
          status: GameStatus.GAME_OVER,
        );
      } else if (GameLogic.victory) {
        AppPage.goto(
          page: GamePage.GAME_OVER,
          buildContext: context,
          status: GameStatus.VICTORY,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;

    double halfWidth = appWidth / 2.0;
    double halfHeight = appHeight / 2.0;

    // margin for the guess board
    double margin =
        (appWidth < appHeight) ? halfWidth * 0.07 : halfHeight * 0.04;

    // card width
    double cardWidth = (halfWidth - margin) * 0.27;

    // card height
    double cardHeight = (halfHeight - margin) * 0.447;

    return Center(
      child: Column(
        children: [
          CustomText(
            title: 'SCORE: ${GameLogic.score}',
            fontFamily: 'Digital-7 Regular',
            color: Colors.white,
            heightRatio: 0.08,
          ),
          SizedBox(
            height: appHeight * 0.02,
          ),
          Row(
            children: [
              Container(
                width: halfWidth - margin,
                height: (appHeight * 0.859) - margin,
                margin: EdgeInsets.all(margin),
                decoration: BoxDecoration(
                  color: Colors.green[900],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  runAlignment: WrapAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < GameLogic.guesses.length; i++)
                      Image.asset(
                        'images/${GameLogic.guesses.elementAt(i)}',
                        width: cardWidth,
                        height: cardHeight,
                      ),
                  ],
                ),
              ),
              Container(
                width: halfWidth - margin - margin,
                height: (appHeight * 0.859) - margin,
                decoration: BoxDecoration(
                  color: Colors.green[900],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/${GameLogic.currentCard}',
                          width: cardWidth,
                          height: cardHeight,
                        ),
                        FlipCard(
                          onFlipDone: (bool done) {
                            if (!done) {
                              _cardKey.currentState!.toggleCard();
                            }
                          },
                          speed: 1000,
                          key: _cardKey,
                          flipOnTouch: false,
                          direction: FlipDirection.HORIZONTAL, // default
                          front: Container(
                            child: Image.asset(
                              'images/FD.jpg',
                              width: cardWidth,
                              height: cardHeight,
                            ),
                          ),
                          back: Container(
                            child: Image.asset(
                              'images/${GameLogic.currentCard}',
                              width: cardWidth,
                              height: cardHeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: appHeight * 0.05,
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.spaceEvenly,
                      children: [
                        CustomRoundButton(
                          icon: Icon(Icons.arrow_upward),
                          color: Colors.red,
                          ratio: 0.1,
                          function: () {
                            guess(true, context);
                            _cardKey.currentState!.toggleCard();
                          },
                        ),
                        SizedBox(
                          width: appWidth * 0.1,
                        ),
                        CustomRoundButton(
                          icon: Icon(Icons.arrow_downward),
                          color: Colors.blue,
                          ratio: 0.1,
                          function: () {
                            guess(false, context);
                            _cardKey.currentState!.toggleCard();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
