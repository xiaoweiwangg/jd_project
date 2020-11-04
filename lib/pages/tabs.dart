import 'package:flutter/material.dart';
import 'package:jd_project/pages/tabs/cart.dart';
import 'package:jd_project/pages/tabs/category.dart';
import 'package:jd_project/pages/tabs/center.dart';
import 'package:jd_project/pages/tabs/home.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _index = 1;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    this._pageController = new PageController(initialPage: this._index);
  }
  List<Widget> _pagelist = [
    HomeCont(),
    CategoryCont(),
    CartCont(),
    CenterCont()
  ];
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('京东'),
      ),
      body: PageView(
        controller: this._pageController,
        children: this._pagelist,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            this._index = value;
            this._pageController.jumpToPage(this._index);
          });
        },
        fixedColor: Colors.red,
        currentIndex: this._index.toInt(),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('分类')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text('购物车')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
      ),
    );
  }
}

