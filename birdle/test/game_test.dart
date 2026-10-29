import 'package:flutter_test/flutter_test.dart';
import 'package:birdle/game.dart';

void main() {
  group('Word & HitType Evaluation Tests', () {
    test('exact match returns all hit', () {
      final target = Word.fromString('aback');
      final guess = Word.fromString('aback');
      final result = guess.evaluateGuess(target);

      expect(result.length, 5);
      for (final letter in result) {
        expect(letter.type, HitType.hit);
      }
    });

    test('partial match handles repeated letters correctly', () {
      final target = Word.fromString('aback');
      final guess = Word.fromString('abbey');
      final result = guess.evaluateGuess(target);

      expect(result[0].char, 'a');
      expect(result[0].type, HitType.hit);
      expect(result[1].char, 'b');
      expect(result[1].type, HitType.hit);
      expect(result[2].char, 'b');
      expect(result[2].type, HitType.miss); // only one 'b' in target
    });
  });

  group('Game State Tests', () {
    test('initial game state', () {
      final game = Game(maxGuesses: 5, seed: 0);
      expect(game.guessesRemaining, 5);
      expect(game.didWin, isFalse);
      expect(game.didLose, isFalse);
      expect(game.activeIndex, 0);
    });

    test('making a winning guess updates didWin', () {
      final game = Game(maxGuesses: 5, seed: 0);
      final targetStr = game.hiddenWord.toString();
      game.guess(targetStr);

      expect(game.didWin, isTrue);
      expect(game.didLose, isFalse);
      expect(game.guessesRemaining, 4);
    });

    test('running out of guesses triggers didLose', () {
      final game = Game(maxGuesses: 2, seed: 0);
      // Hidden word for seed 0 is legalWords[0] = 'aback'
      game.guess('abase');
      expect(game.didWin, isFalse);
      expect(game.didLose, isFalse);

      game.guess('abate');
      expect(game.didWin, isFalse);
      expect(game.didLose, isTrue);
      expect(game.guessesRemaining, 0);
    });
  });
}
