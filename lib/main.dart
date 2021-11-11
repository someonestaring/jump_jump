import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:control_pad/control_pad.dart';

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
  int _score = 0;

  void _incrementScore() {
    setState(() {
      _score++;
    });
  }

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
              style: const TextStyle(color: Colors.white70, fontSize: 24),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _active = !_active;
                  _moving = !_moving;
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

    // Widget _character() {
    //   return;
    // }
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
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.025),
              child: PadButtonsView(
                padButtonPressedCallback: (button, tap) {
                  switch (button) {
                    case 0:
                      return print('Button $button pressed you dumbie');
                    case 1:
                      return print('Button $button pressed you dumbie');
                    case 2:
                      return print('Button $button pressed you dumbie');
                    case 3:
                      return print('Button $button pressed you dumbie');
                    default:
                  }
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
            // _character(),
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
