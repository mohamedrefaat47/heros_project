import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heros_demo/custom_widgets/connectivity/network_indicator.dart';
import 'package:heros_demo/custom_widgets/custom_appbar/custom_appbar.dart';
import 'package:heros_demo/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:heros_demo/custom_widgets/safe_area/page_container.dart';
import 'package:heros_demo/providers/home_provider.dart';
import 'package:heros_demo/ui/all_heroes/widgets/hero_widget.dart';
import 'package:heros_demo/utils/app_colors.dart';
import 'package:heros_demo/utils/commons.dart';
import 'package:heros_demo/utils/no_data.dart';
import 'package:provider/provider.dart';

class AllHeroesScreen extends StatefulWidget {
  @override
  _AllHeroesScreenState createState() => _AllHeroesScreenState();
}

class _AllHeroesScreenState extends State<AllHeroesScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _seacrhTextEditingController = TextEditingController();
  String _keySearch = '';
  bool _intialRun = true;
  HomeProvider _homeProvider;

  Animation<double> animation;
  AnimationController animationController;

  double _width = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (_intialRun) {
      _homeProvider = Provider.of(context, listen: false);
      _homeProvider.getAllHeroesList(context: context);

      _intialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
                appBar: CustomAppbar(
                  title: "All Heroes",
                  trailingWidget: IconButton(
                      icon: Icon(
                        Icons.filter_alt,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _homeProvider.toggleFilters();
                      }),
                ),
                resizeToAvoidBottomPadding: false,
                body: Consumer<HomeProvider>(
                  builder: (ctx, homeProv, child) => Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        transform: Transform.translate(
                          offset: Offset(
                              homeProv.hideFilters == true ? -_width : 0, 0),
                        ).transform,
                        child: Column(
                          children: [
                            CustomTextFormField(
                                controller: _seacrhTextEditingController,
                                enableBorder: true,
                                onChangedFunc: (String text) {
                                  if (text.trim().length > 0) {
                                    _keySearch = text.trim();
                                  }
                                },
                                hasHorizontalMargin: true,
                                hintTxt: 'Search....',
                                hintStyle: TextStyle(
                                    color: mainAppColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: mainAppColor,
                                  ),
                                  onPressed: () {
                                    if (_keySearch.trim().length > 0) {
                                      _seacrhTextEditingController.clear();
                                      _homeProvider.setKeySearch('',
                                          isNotifyListener: true);
                                      _keySearch = '';
                                      _homeProvider.setDisplayedList(
                                          _homeProvider.allHeroesList);
                                      // FocusScope.of(context).unfocus();
                                    }
                                  },
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: mainAppColor,
                                  ),
                                  onPressed: () {
                                    if (_keySearch.length > 0) {
                                      _homeProvider.setKeySearch(_keySearch,
                                          isNotifyListener: true);
                                      _homeProvider.setSearchResults();
                                      //  FocusScope.of(context).unfocus();
                                    } else {
                                      FocusScope.of(context).unfocus();
                                      Commons.showToast(
                                          message:
                                              'Please enter the search keyword !',
                                          color: Colors.red,
                                          context: context);
                                    }
                                  },
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sort By Power',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black87),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                CupertinoSwitch(
                                    value: homeProv.sortByPower,
                                    activeColor: Colors.green,
                                    onChanged: (bool val) {
                                      print(val);
                                      if (val == false) {
                                        homeProv
                                            .sortByName(homeProv.displayedList);
                                      } else {
                                        homeProv.sortByPowerFunc(
                                            homeProv.displayedList);
                                      }

                                      homeProv.setSortByPowerFlag(val);
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: AnimatedContainer(
                            duration: Duration(
                                milliseconds:
                                    homeProv.hideFilters == true ? 700 : 500),
                            transform: Transform.translate(
                                    offset: Offset(0,
                                        homeProv.hideFilters == true ? -95 : 0))
                                .transform,
                            child: homeProv.allherosLoading
                                ? Center(
                                    child: SpinKitFadingCircle(
                                        color: mainAppColor),
                                  )
                                : homeProv.displayedList.length > 0
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12.0, left: 12.0),
                                        child: ListView.builder(
                                          itemCount:
                                              homeProv.displayedList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return HeroWidget(
                                                homeProv.displayedList[index]);
                                          },
                                        ),
                                      )
                                    : Center(
                                        child: NoData(message: "No results"))),
                      )
                    ],
                  ),
                ))));
  }
}
