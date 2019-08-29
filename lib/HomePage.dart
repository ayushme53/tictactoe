import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage edit = AssetImage("images/edit.png");

  int delay = 1200;
  bool isCross = true;
  bool isGameResetClicked = false;
  bool isGameOver = false;
  bool isToastDisplayed=false;
  String message;
  List<String> gameState;


  @override
  void initState() {
    super.initState();
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty"
      ];
      this.message = "";
    });
  }


  void resetGame() {
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty"
      ];
      this.message = "";
      this.isGameResetClicked = true;
      this.isGameOver = false;
      this.isToastDisplayed=false;
    });
  }

  void autoRest() {
    Future.delayed(const Duration(milliseconds: 4000), () {
      if (!this.isGameResetClicked) {
        this.resetGame();
        this.isGameResetClicked = false;
      }
    });
  }


  getImage(String value) {
    switch (value) {
      case "empty":
        return edit;
      case "circle":
        return circle;
      case "cross":
        return cross;
    }
  }


  playGame(int index,context) {
    if (!isGameOver) {
      if (this.gameState[index] == 'empty') {
        setState(() {
          if (this.isCross) {
            this.gameState[index] = 'cross';
          } else {
            this.gameState[index] = 'circle';
          }
          this.isCross = !this.isCross;
          this.winLogic();
        });
      }
    } else {
      this.showToast(context);
    }
  }


  winLogic() {
    if (gameState[0] != 'empty' &&
        gameState[0] == gameState[1] &&
        gameState[1] == gameState[2]) {
      setState(() {
        this.message = '${gameState[0]} -wins';
        this.isGameOver = true;
      });
      autoRest();
    } else if (gameState[3] != 'empty' &&
        gameState[3] == gameState[4] &&
        gameState[4] == gameState[5]) {
      setState(() {
        this.message = '${gameState[3]} -wins';
        this.isGameOver = true;
      });
      autoRest();
    } else if (gameState[6] != 'empty' &&
        gameState[6] == gameState[7] &&
        gameState[7] == gameState[8]) {
      setState(() {
        this.message = '${gameState[6]} -wins';
        this.isGameOver = true;
      });
      autoRest();
    } else if (gameState[0] != 'empty' &&
        gameState[0] == gameState[3] &&
        gameState[3] == gameState[6]) {
      setState(() {
        this.message = '${gameState[0]} -wins';
        this.isGameOver = true;
      });
      autoRest();
    } else if (gameState[1] != 'empty' &&
        gameState[1] == gameState[4] &&
        gameState[4] == gameState[7]) {
      setState(() {
        this.message = '${gameState[1]} -wins';
        this.isGameOver = true;
      });
      autoRest();
    } else if (gameState[2] != 'empty' &&
        gameState[2] == gameState[5] &&
        gameState[5] == gameState[8]) {
      setState(() {
        this.message = '${gameState[2]} -wins';
        this.isGameOver = true;
      });
      autoRest();
    } else if (gameState[0] != 'empty' &&
        gameState[0] == gameState[4] &&
        gameState[4] == gameState[8]) {
      setState(() {
        this.message = '${gameState[0]} -wins';
        this.isGameOver = true;
      });
      autoRest();
    } else if (gameState[2] != 'empty' &&
        gameState[2] == gameState[4] &&
        gameState[4] == gameState[6]) {
      setState(() {
        this.message = '${gameState[2]} -wins';
        this.isGameOver = true;
      });
      autoRest();
    } else if (!gameState.contains('empty')) {
      setState(() {
        this.message = 'Game Draw';
        this.isGameOver = true;
      });
      autoRest();
    }
  }

  showToast(context) {
    if(!isToastDisplayed){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Game Over!"),
    ));
    isToastDisplayed=true;
  }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: GridView.builder(
            padding: EdgeInsets.all(20.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0),
            itemCount: this.gameState.length,
            itemBuilder: (context, i) => SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: MaterialButton(
                    shape: Border.all(color: Colors.black),
                    onPressed: () {
                      playGame(i,context);
                    },
                    child: Image(
                      image: this.getImage(this.gameState[i]),
                    ),
                  ),
                ),
          )),
          Container(
              padding: EdgeInsets.all(20.0),
              child: Text(this.message,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
          MaterialButton(
            color: Colors.blue,
            minWidth: 300.0,
            height: 50.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Text("Reset Game",
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
            onPressed: () {
              this.resetGame();
            },
          ),
          
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Developed by Ayush Mehra",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
