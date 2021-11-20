import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mvvm/pages/home/home_vm.dart';
import 'package:mvvm/pages/home/top_headlines/top_headlines.dart';
import 'package:mvvm/util/extention.dart';
import 'package:mvvm/util/logger.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    Log.i("home");

    super.initState();
    _tabController = TabController(
        length: context.read<HomeVM>().categories.length,
        vsync: this,
        initialIndex: 0);

    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Iconsax.home5),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (c) {
                      return Column(
                        children: [
                          AppBar(
                            title: const Text("County"),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount:
                                    context.read<HomeVM>().countries.length,
                                itemBuilder: (c, i) {
                                  return ListTile(
                                    onTap: () {
                                      context.read<HomeVM>().setCountyIndex(i);
                                      _tabController.animateTo(0);
                                      Navigator.maybePop(context);
                                    },
                                    title: Text(
                                        context.read<HomeVM>().countries[i]),
                                  );
                                }),
                          ),
                        ],
                      );
                    });
              },
              icon: Text(context.watch<HomeVM>().currentCounty),
            )
          ],
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            onTap: (v) {
              _pageController.jumpToPage(v);
            },
            tabs: List.generate(
                context.read<HomeVM>().categories.length,
                (index) => Tab(
                      text: context
                          .read<HomeVM>()
                          .categories[index]
                          .toCapitalize(),
                    )),
          ),
        ),
        body: PageView.builder(
            key: UniqueKey(),
            controller: _pageController,
            onPageChanged: (v) {
              _tabController.animateTo(v);
            },
            itemCount: context.read<HomeVM>().categories.length,
            itemBuilder: (c, index) {
              return ChangeNotifierProvider.value(
                key: PageStorageKey(
                    "ChangeNotifierProvider${context.read<HomeVM>().categories[index]}"),
                value: context
                    .read<HomeVM>()
                    .getPage(context.read<HomeVM>().categories[index]),
                child: const TopHeadlines(),
              );
            }));
  }
}
