import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
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
        title: Container(
          // padding: EdgeInsets.only(left: 25.w),
          width: 500.w,
          height: 70.h,
          child: TextField(
            style: TextStyle(color: Colors.white, height: .8),
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .2),
              borderRadius: BorderRadius.circular(40.w)),
        ),
        actions: [
          InkWell(
            onTap: () {
              print('搜索');
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Text('body asearch'),
    );
  }
}
