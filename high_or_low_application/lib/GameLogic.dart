import 'dart:collection';

import 'package:flutter/services.dart' show rootBundle;

abstract class GameLogic {
  static late List<String> _imageNames = [];

  static int _score = 0;
  static bool _gameOver = false;
  static bool _victory = false;
  static late String _contents;
  static late String _current; // current card
  static late String _guess; // card to be guessed

  String faceDown = 'FD.JPG'; // face down card

  static Queue<String> guesses = Queue<String>();

  static int get score => _score;
  static bool get gameOver => _gameOver;
  static bool get victory => _victory;
  static String get currentCard => _current;
  static String get guess => _guess;

  // get contents in text file
  static Future<void> loadImageNames() async {
    _contents = await rootBundle.loadString('assets/imageNames.txt');
  }

  // reset
  static void reset() {
    _score = 0;
    _gameOver = false;
    _victory = false;
    _imageNames.clear();
    guesses.clear();

    _imageNames = _contents.split('\n').toList();

    for (int i = 0; i < _imageNames.length - 1; i++) {
      _imageNames[i] = _imageNames[i].substring(0, _imageNames[i].length - 1);
    }

    // shuffles the cards
    _imageNames.shuffle();

    // get current card
    _current = _imageNames.first;
    _imageNames.removeAt(0);
    // get card to be guessed
    _guess = _imageNames.first;
    _imageNames.removeAt(0);
  }

  static void game(bool highOrEqual) {
    int currVal = 0;
    int guessVal = 0;

    // get value of current card
    if (_current.codeUnitAt(0) >= 48 && _current.codeUnitAt(0) <= 57) {
      String nCurrent = _current.replaceAll(RegExp(r'[^0-9]'), '');
      currVal = int.parse(nCurrent);
    } else {
      currVal = _getValue(_current.codeUnitAt(0));
    }

    // get value of the card to be guessed
    if (_guess.codeUnitAt(0) >= 48 && _guess.codeUnitAt(0) <= 57) {
      String nGuess = _guess.replaceAll(RegExp(r'[^0-9]'), '');
      guessVal = int.parse(nGuess);
    } else {
      guessVal = _getValue(_guess.codeUnitAt(0));
    }

    // if guess if correct
    if ((currVal <= guessVal && highOrEqual) ||
        (currVal > guessVal && !highOrEqual)) {
      _score++;

      // victory
      if (_score == 51) {
        _victory = true;
      } else {
        // if there are already 5 guessed cards displayed, remove one card
        if (guesses.length == 5) guesses.removeFirst();

        // add current card to guess list
        guesses.add(_current);
        // set current to the guessed card
        _current = _guess;
        // set next card as the card to be guessed
        _guess = _imageNames.first;
        // remove front card from image list
        _imageNames.removeAt(0);
      }
    }
    // lose
    else {
      _gameOver = true;
    }
  }

  // value of A, J, Q, K
  static int _getValue(int c) {
    int value = 0;
    switch (c) {
      case 65:
        value = 1;
        break;

      case 74:
        value = 11;
        break;

      case 81:
        value = 12;
        break;

      case 75:
        value = 13;
        break;
    }
    return value;
  }
}
