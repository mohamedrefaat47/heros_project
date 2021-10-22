import 'package:flutter/material.dart';
import 'package:heros_demo/custom_widgets/connectivity/network_indicator.dart';
import 'package:heros_demo/custom_widgets/custom_appbar/custom_appbar.dart';
import 'package:heros_demo/custom_widgets/safe_area/page_container.dart';
import 'package:heros_demo/models.dart/hero.dart';

class HeroDetailsScreen extends StatelessWidget {
  HeroItem _heroItem;
  HeroDetailsScreen(this._heroItem);

  double _width = 0;
  double _height = 0;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height - 60;
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
      appBar: CustomAppbar(
        title: "${_heroItem.heroName}",
        hasBackBtn: true,
      ),
      body: Container(
        width: _width,
        height: _height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: _height / 20,
            ),
            Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('assets/images/marvellogo.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(
              height: _height / 30,
            ),
            Center(
              child: Text(
                _heroItem.heroName,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: _height / 15,
            ),
            Container(
              width: _width,
              child: Text(
                "Description",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              _heroItem.description,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: _height / 15,
            ),
            Container(
              width: _width,
              child: Text(
                "Powers",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: _width,
              child: Text(
                _heroItem.powers,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    )));
  }
}
