import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //1. Import Images
  AssetImage circle = const AssetImage('images/circle.png');
  AssetImage lucky = const AssetImage('images/rupee.png');
  AssetImage unlucky = const AssetImage('images/sadFace.png');

  //2. Get an Array
  late List<String> itemArray;
  late int luckNumber;

  //3. initialise array with 25 elements
  @override
  void initState() {
    super.initState();

    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    print(random);
    setState(() {
      luckNumber = random;
    });
  }

  //4. define a getImage method
  AssetImage getImage(int index) {
    String currentImage = itemArray[index];

    switch (currentImage) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }

    return circle;
  }

  //5. play game method
  playGame(int index) {
    if (luckNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
      });
    } else {
      setState(() {
        itemArray[index] = "unlucky";
      });
    }
  }

  //6. showall
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckNumber] = "lucky";
    });
  }

  //7. Reset
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch and Win"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                    onPressed: () {
                      this.playGame(i);
                    },
                    child: Image(
                      image: this.getImage(i),
                    )),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.all(15.0),
              child: RaisedButton(
                onPressed: () {
                  this.showAll();
                },
                child: Text("Show All"),
                color: Colors.grey,
                padding: EdgeInsets.all(20.0),
              )),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(onPressed: () {
              this.resetGame();
            },
            child: Text("Reset Game"),
            padding: EdgeInsets.all(20.0),
            color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
