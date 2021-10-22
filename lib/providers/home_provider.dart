import 'package:flutter/material.dart';
import 'package:heros_demo/models.dart/hero.dart';
import 'package:heros_demo/networking/api_provider.dart';
import 'package:heros_demo/utils/commons.dart';
import 'package:heros_demo/utils/urls.dart';

class HomeProvider extends ChangeNotifier {
  ApiProvider _apiProvider = ApiProvider();

  bool _allherosLoading = true;
  bool get allherosLoading => _allherosLoading;

  void toggleAllherosLoading() {
    _allherosLoading = !_allherosLoading;
    notifyListeners();
  }

  List<HeroItem> _allHeroesList = [];

  List<HeroItem> get allHeroesList => _allHeroesList;

  Future<List<HeroItem>> getAllHeroesList({
    BuildContext context,
  }) async {
    final results = await _apiProvider.get(Urls.All_HEROES_URL);

    if (results['status_code'] == 200) {
      Iterable iterable = results['response']['data'];

      _allHeroesList =
          iterable.map((model) => HeroItem.fromJson(model)).toList();

      setDisplayedList(_allHeroesList);

      sortByName(_displayedList);

      toggleAllherosLoading();
    } else {
      Commons.showError(
          context: context, message: results['response']["message"]);
    }

    return _allHeroesList;
  }

  List<HeroItem> _displayedList = [];

  List<HeroItem> get displayedList => _displayedList;

  void setDisplayedList(List<HeroItem> list) {
    _displayedList = list;
    notifyListeners();
  }

  void sortByName(List<HeroItem> list) {
    _displayedList.sort((a, b) {
      return a.heroName[0].toLowerCase().compareTo(b.heroName[0].toLowerCase());
    });
    notifyListeners();
  }

  void sortByPowerFunc(List<HeroItem> list) {
    _displayedList.sort((a, b) {
      return b.powers[0].toLowerCase().compareTo(a.powers[0].toLowerCase());
    });
    notifyListeners();
  }

  bool _enableSearch = false;

  bool get enableSearch => _enableSearch;

  void updateEnableSearch(bool value, {bool isNotifyListener: false}) {
    _enableSearch = value;
    print("_enableSearch $_enableSearch");
    if (isNotifyListener) notifyListeners();
  }

  bool _sortByPower = false;

  bool get sortByPower => _sortByPower;

  void setSortByPowerFlag(bool val) {
    _sortByPower = val;
    print('sort by power : ${_sortByPower}');
    notifyListeners();
  }

  String _keySearch = '';

  void setKeySearch(String keySeacrh, {bool isNotifyListener: false}) {
    _keySearch = keySeacrh;
    if (isNotifyListener) notifyListeners();
  }

  String get keySearch => _keySearch;

  void setSearchResults() {
    Iterable<HeroItem> _searchList = _allHeroesList.where((element) =>
        element.heroName.toLowerCase().contains(_keySearch) ||
        element.powers.toLowerCase().contains(_keySearch));

    _displayedList = _searchList.map((e) => e).toList();
    if (_sortByPower)
      sortByPowerFunc(_displayedList);
    else
      sortByName(_displayedList);
  }

  bool _hideFilters = false;
  bool get hideFilters => _hideFilters;

  void toggleFilters() {
    _hideFilters = !_hideFilters;
    notifyListeners();
  }
}
