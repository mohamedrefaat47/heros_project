import 'package:flutter/material.dart';
import 'package:heros_demo/models.dart/hero.dart';
import 'package:heros_demo/ui/hero_details/hero_details_screen.dart';
import 'package:heros_demo/utils/app_colors.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class HeroWidget extends StatelessWidget {
  HeroItem _heroItem;
  HeroWidget(this._heroItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => HeroDetailsScreen(_heroItem)));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(12),
        height: 150,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _buildRowItem(title: 'Hero name', value: _heroItem.heroName),
            Divider(
              color: Colors.grey,
            ),
            _buildRowItem(title: 'Powers', value: _heroItem.powers),
            Divider(
              color: Colors.grey,
            ),
            _buildRowItem(
                title: 'Rate',
                value: _heroItem.rate.toString(),
                isRatingRow: true)
          ],
        ),
      ),
    );
  }

  Widget _buildRowItem(
      {@required String title,
      @required String value,
      bool isRatingRow: false}) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                color: Color(0xff747474),
                fontWeight: FontWeight.w600),
          ),
          isRatingRow
              ? SmoothStarRating(
                  starCount: 5,
                  rating: double.parse(value),
                  size: 17.0,
                  color: mainAppColor,
                  borderColor: mainAppColor,
                  spacing: 0.0)
              : Text(
                  value,
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff747474),
                      fontWeight: FontWeight.w600),
                )
        ],
      ),
    );
  }
}
