import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/news.dart';
import 'package:mvvm/pages/home/top_headlines/top_headlines_vm.dart';
import 'package:mvvm/util/logger.dart';
import 'package:provider/provider.dart';

class TopHeadlines extends StatefulWidget {
  const TopHeadlines({
    Key? key,
  }) : super(key: key);

  @override
  State<TopHeadlines> createState() => _TopHeadlinesState();
}

class _TopHeadlinesState extends State<TopHeadlines> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      loadMore();
    });
  }

  void loadMore() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      Log.d("${_scrollController.position.maxScrollExtent}");
      context.read<TopHeadlinesVM>().nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    TopHeadlinesVM topHeadlinesVM = context.watch<TopHeadlinesVM>();
    return topHeadlinesVM.error != null && topHeadlinesVM.article.isEmpty
        ? Center(child: Text(topHeadlinesVM.error.toString()))
        : ListView.builder(
            controller: _scrollController,
            itemCount: topHeadlinesVM.status == Status.loading
                ? topHeadlinesVM.article.length + 1
                : topHeadlinesVM.article.length,
            itemBuilder: (c, i) {
              if (i == topHeadlinesVM.article.length) {
                return const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: CupertinoActivityIndicator()),
                );
              }
              Article article = topHeadlinesVM.article[i];
              return InkWell(
                  onTap: () {}, child: ArticleListItem(article: article));
            });
  }
}

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) => placeHolder(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  article.title ?? "",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  article.description ?? "",
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container placeHolder() {
    return Container(
      color: Colors.blueGrey.shade200,
      alignment: Alignment.center,
      child: const CupertinoActivityIndicator(),
    );
  }
}
