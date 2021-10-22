import 'package:flutter/material.dart';
import 'package:heros_demo/ui/all_heroes/all_heroes_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _height = 0, _width = 0;

  Future<Null> navigateToHerosPage() async {
    await Future.delayed(Duration(
      milliseconds: 2000,
    )).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => AllHeroesScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToHerosPage();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/marvellogo.png',
        fit: BoxFit.cover,
        height: _width / 1.7,
        width: _width / 1.7,
      ),
    ));
  }
}
