import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:control_pad/control_pad.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jump Jump',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Jump Jump'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _active = false;
  bool _moving = false;
  String _charStatus = 'idle';
  int _score = 0;

  static void _counter(void Function() callback) {
    Timer(const Duration(milliseconds: 95), callback);
  }

  void _incrementScore() {
    if (_moving && _score < 999999) {
      setState(() {
        _score++;
      });
    }
  }

  // double charJump() {
  // TODO process of scooching character padding up and down blah blah --> Animation??
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // PreferredSizeWidget? _appBar() {
    //   return AppBar(
    //     title: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         const Spacer(),
    //         Text(
    //           widget.title,
    //         ),
    //         const Spacer(),
    //         Text('Score: $_score'),
    //       ],
    //     ),
    //   );
    // }

    Widget _background() {
      return _moving
          ? Image.asset(
              'assets/gifs/moving_screen.gif',
              fit: BoxFit.fitWidth,
              width: size.width,
            )
          : Image.asset(
              'assets/images/start_screen.png',
              fit: BoxFit.fitWidth,
              // width: size.height,
            );
    }

    Widget _userInfo() {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const Spacer(),
            Text(
              'UserNameScoreStuffWhyNot: $_score',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _active = !_active;
                  _moving = !_moving;
                  _charStatus = _moving ? 'walk' : 'idle';
                });
              },
              child: Icon(
                !_active ? Icons.play_arrow : Icons.pause,
                color: Colors.white70,
                size: 44,
              ),
            ),
          ],
        ),
      );
    }

    Widget _character() {
      String type = 'idle';
      switch (_charStatus) {
        case 'idle':
          type = 'idle';
          break;
        case 'walk':
          type = 'walk';
          _counter(_incrementScore);
          break;
        case 'jump':
          type = 'jump';
      }
      return Padding(
          padding:
              EdgeInsets.only(top: size.height * 0.5, left: size.width * 0.3),
          child: Image.asset(
            'assets/gifs/skeleton-$type.gif',
            scale: 4,
          ));
    }

// Widget _obstacles() {
//   return
// }

    Widget _joysticks() {
      return Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.025),
              child: JoystickView(
                size: size.width * 0.15,
                showArrows: false,
                // onDirectionChanged: (x, y) {
                //   setState(() {
                //     switch (x.isNegative) {
                //       case true:
                //         _charStatus = 'idle';
                //         break;
                //       case false:
                //         _charStatus = 'walk';
                //         break;
                //       default:
                //     }
                //   });
                // },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.025),
              child: PadButtonsView(
                padButtonPressedCallback: (button, tap) {
                  setState(() {
                    switch (button) {
                      case 0:
                        return print('Button $button pressed you dumbie');
                      case 1:
                        _charStatus = 'jump';
                        return print('Button $button pressed you dumbie');

                      case 2:
                        return print('Button $button pressed you dumbie');
                      case 3:
                        return print('Button $button pressed you dumbie');
                    }
                  });
                },
                size: size.width * 0.2,
              ),
            ),
          ],
        ),
      );
    }

    Widget _bodyContent() {
      return Center(
        child: Stack(
          children: [
            _background(),
            _userInfo(),
            _character(),
            // _obstacles(),
            _joysticks(),
          ],
        ),
      );
    }

    return Scaffold(
      // appBar: _appBar(),
      body: _bodyContent(),
    );
  }
}
