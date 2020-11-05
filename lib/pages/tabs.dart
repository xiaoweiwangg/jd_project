import 'package:flutter/material.dart';
import 'package:jd_project/pages/tabs/cart.dart';
import 'package:jd_project/pages/tabs/category.dart';
import 'package:jd_project/pages/tabs/center.dart';
import 'package:jd_project/pages/tabs/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _index = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    this._pageController = new PageController(initialPage: this._index);
  }

  @override
  void dispose() {
    //记得要销毁哦
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _pagelist = [
    HomeCont(),
    CategoryCont(),
    CartCont(),
    CenterCont()
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    // super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          height: 30,
          width: 30,
          child: Icon(
            Icons.center_focus_strong,
            size: 30,
          ),
        ),
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
          child: Container(
            padding: EdgeInsets.only(left: 25.w),
            width: 550.w,
            height: 70.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '搜索你想要的',
                  style: TextStyle(
                    fontSize: 30.sp,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, .2),
                borderRadius: BorderRadius.circular(40.w)),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Icon(
              Icons.phone_in_talk,
              size: 30,
            ),
          )
        ],
      ),
      body: PageView(
        controller: this._pageController,
        children: this._pagelist,
        // physics: NeverScrollableScrollPhysics(),
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
