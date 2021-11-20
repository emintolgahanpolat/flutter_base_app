import 'package:flutter/material.dart';
import 'package:mvvm/model/news.dart';
import 'package:mvvm/network/api_service.dart';
import 'package:mvvm/network/dio_client.dart';
import 'package:mvvm/network/error_interceptor.dart';
import 'package:mvvm/util/logger.dart';

enum Status { loading, success, error, finish }

class TopHeadlinesVM extends ChangeNotifier {
  Future<List<Article>>? _future;
  Future<List<Article>> get future => _future ?? Future.value(article);
  List<Article> article = [];
  DioCustomError? error;
  Status _status = Status.success;
  Status get status => _status;
  String _category = "";
  String _country = "tr";

  TopHeadlinesVM(String category, String country) {
    _category = category;
    _country = country;
    fetchData();
  }

  int _page = 1;
  void nextPage() {
    if (Status.success == status) {
      Log.w("Load More");
      _page++;
      fetchData();
      notifyListeners();
    }
  }

  Future<void>? fetchData() async {
    _status = Status.loading;
    notifyListeners();
    Log.w("$_page $_category $_country", tag: "Page Index");
    try {
      var res = await DioClient.instance.get(ApiService.topHeadlines,
          queryParameters: {
            "category": _category,
            "country": _country,
            "pageSize": 4,
            "page": _page
          });

      List<Article>? mList = News.fromJson(res.data).articles;
      if (mList != null && mList.isNotEmpty) {
        article.addAll(mList);
      } else {
        _status = Status.finish;
      }

      _status = Status.success;
      notifyListeners();
    } on DioCustomError catch (e) {
      _status = Status.error;
      error = e;
      notifyListeners();
    }
  }

  int value = 0;
  List<Article> generateDummyData() {
    List<Article> _article = [];
    for (var i = 0; i < 4; i++) {
      value++;
      _article.add(Article(
          author: "author $value",
          content: "content $value",
          description: "description $value",
          publishedAt: DateTime.now(),
          source: Source(name: ""),
          title: "title $value",
          url: "url",
          urlToImage: "https://randomuser.me/api/portraits/women/$value.jpg"));
    }

    return _article;
  }

  @override
  void dispose() {
    Log.i("$_category $_country TopHeadlinesVM", tag: "Dispose");
    super.dispose();
  }
}
