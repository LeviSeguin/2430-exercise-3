import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:exercise_3_2430/bucket.dart';
import 'package:exercise_3_2430/ball.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  //player variables
  double playerX = -0.2;
  double playerY = 0.7;
  double bucketWidth = 0.3;
  double bucketHeight = 0.3;
  int score = 0;
  int highScore = 0;

  //game variables
  bool gameStarted = false;
  double ballY = -1;
  double ballX = 0;
  double ballSpeed = 0.01;
  double ballSize = 0.1;

  void movePlayer(DragUpdateDetails update) {
    setState(() {
      double n = update.delta.dx / (MediaQuery.of(context).size.width / 2);
      if (playerX + n >= -1 && playerX + bucketWidth + n <= 1) {
        playerX += n;
      }
    });
  }

  void moveBall() {
    setState(() {
     ballY += ballSpeed;
    });
  }

  void resetBall() {
    var rng = Random();
    ballX = (rng.nextDouble() * 2) - 1;
    ballY = -1;
    ballSpeed += 0.001;
  }

  void checkBall() {
    if (ballY > 1) {
      //gameOver
      score = 0;
      resetBall();
      ballSpeed = 0.01;
    } else if (ballY - ballSize/2 >= playerY - bucketHeight && ballY - ballSize/2 <= playerY - (bucketHeight * 0.8) && playerX <= ballX && playerX + bucketWidth >= ballX) {
      score++;
      if (highScore < score) {
        highScore++;
      }
      resetBall();
    }
  }

  //game loop
  void startGame() {
    gameStarted = true;
    Timer.periodic(
        Duration(milliseconds: 17), (timer) {
      moveBall();
      checkBall();
    });
  }

  @override

  Widget build(BuildContext context) {
    if (!gameStarted) {
      startGame();
    }

    return Scaffold(
        backgroundColor: Colors.purple,
        body: Center(
            child: Stack(
          children: [
            GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails update) =>
                    movePlayer(update),
                child: Bucket(playerX, playerY, bucketWidth, bucketHeight)
            ),
            Score(score, highScore),
            Ball(ballX, ballY, ballSize),

          ],
        )));
  }
}

class Score extends StatelessWidget {
  late final playerScore;
  late final highScore;
  Score(this.playerScore, this.highScore);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          alignment: Alignment(-0.9, 0.9),
          child: Text(
            playerScore.toString(),
            style: TextStyle(color: Colors.grey[400], fontSize: 40),
          )),
      Container(
          alignment: Alignment(0.9, 0.9),
          child: Text(
            "Best: " + highScore.toString(),
            style: TextStyle(color: Colors.grey[400], fontSize: 40),
          )),
    ]);
  }
}
