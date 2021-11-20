import 'package:flutter/material.dart';
import 'package:mvvm/pages/home/top_headlines/top_headlines_vm.dart';

class HomeVM extends ChangeNotifier {
  final Map<String, TopHeadlinesVM> _mapPage = {};
  TopHeadlinesVM getPage(String key) {
    TopHeadlinesVM? mItem = _mapPage[key];
    if (mItem != null) {
      return mItem;
    } else {
      _mapPage[key] = TopHeadlinesVM(key, currentCounty);
      return getPage(key);
    }
  }

  final List<String> _categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];
  List<String> get categories => _categories;
  final List<String> _countries = [
    "ae",
    "ar",
    "at",
    "au",
    "be",
    "bg",
    "br",
    "ca",
    "ch",
    "cn",
    "co",
    "cu",
    "cz",
    "de",
    "eg",
    "fr",
    "gb",
    "gr",
    "hk",
    "hu",
    "id",
    "ie",
    "il",
    "in",
    "it",
    "jp",
    "kr",
    "lt",
    "lv",
    "ma",
    "mx",
    "my",
    "ng",
    "nl",
    "no",
    "nz",
    "ph",
    "pl",
    "pt",
    "ro",
    "rs",
    "ru",
    "sa",
    "se",
    "sg",
    "si",
    "sk",
    "th",
    "tr",
    "tw",
    "ua",
    "us",
    "ve",
    "za"
  ];
  List<String> get countries => _countries;
  int _countryIndex = 48;
  String get currentCounty => countries[_countryIndex];

  void setCountyIndex(int index) {
    _countryIndex = index;
    _mapPage.clear();
    notifyListeners();
  }
}
