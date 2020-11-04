import 'package:flutter/material.dart';
//适配屏幕插件
import 'package:flutter_screenutil/flutter_screenutil.dart';
//轮播图插件
import 'package:flutter_swiper/flutter_swiper.dart';
//api
import '../../service/api.dart';
//数据请求库
import 'package:dio/dio.dart';
import 'dart:convert';
//数据模型
import 'package:jd_project/models/hotpromodel.dart';
import 'package:jd_project/models/focusmodel.dart';

class HomeCont extends StatefulWidget {
  @override
  _HomeContState createState() => _HomeContState();
}

class _HomeContState extends State<HomeCont>
    with AutomaticKeepAliveClientMixin {
  List focusdata = [];
  List<Widget> hotproduct = [];
  @override
  initState() {
    print('home init page ');
    this.getfoucsdata();
    this.gethotproduct();
  }

//获取轮播图数据方法
  getfoucsdata() async {
    var data = await Dio().get(Config.api + 'api/focus');
    setState(() {
      this.focusdata = FocusModel.fromJson(json.decode(data.toString())).result;
      print(this.focusdata[0].pic);
    });
  }

//获取热门商品数据方法
  gethotproduct() async {
    var api = '${Config.api}api/plist?is_hot=1';
    var data = await Dio().get(api);
    print('商品数据' + Config.api + 'public/upload/NkuiIr9puaI7cSxZHfz8UYOT.jpg');
    setState(() {
      var hotmodel = HotModel.fromJson(json.decode(data.toString())).result;
      this.hotproduct = hotmodel.map((e) {
        return _singleproduct(e);
      }).toList();
    });
  }

//轮播图组件
  Widget _swiperwidget() {
    if (this.focusdata.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return new Image.network(
                'http://jd.itying.com/${this.focusdata[index].pic.replaceAll("\\", "/")}',
                fit: BoxFit.cover,
              );
            },
            itemCount: this.focusdata.length,
            pagination: new SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Text('loading...');
    }
  }

//标题组件
  Widget _titlewidget(value) {
    return Container(
      padding: EdgeInsets.only(left: 10.w),
      margin: EdgeInsets.only(left: 10.w, top: 10.w, bottom: 10.w),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.red, width: 6.w))),
      child: Text(value),
    );
  }

//猜你喜欢组件
  Widget _gusyourlike() {
    return Container(
      height: 160.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Column(
                children: [
                  Container(
                    height: 120.h,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                        'https://www.itying.com/images/flutter/hot${index + 1}.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 30.h,
                    child: Text('第${index + 1}条'),
                  )
                ],
              ),
            );
          }),
    );
  }

//单个商品组件
  Widget _singleproduct(product) {
    return Container(
        margin: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
            border: Border.all(width: 1.w, color: Color(0xffe7e7e7))),
        width: (1.sw - 20.w - 6.w * 4) / 2,
        padding: EdgeInsets.all(6.w),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Container(
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                      '${Config.api}${product.pic.replaceAll("\\", '/')}'),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 70.h,
                child: Center(
                  child: Text(
                    product.title,
                    maxLines: 2,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10.h,
              // ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '￥${product.price}',
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      '￥${product.oldPrice}',
                      style: TextStyle(
                          color: Colors.black45,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

//热门商品组件
  Widget _hotprowidget() {
    if (this.hotproduct.length > 0) {
      return Container(
        width: 1.sw,
        padding: EdgeInsets.all(10.w),
        child: Wrap(
          children: this.hotproduct,
        ),
      );
    } else {
      return Text('loading');
    }
  }

  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return ListView(
      children: [
        _swiperwidget(),
        _titlewidget('猜你喜欢'),
        _gusyourlike(),
        _titlewidget('热门推荐'),
        _hotprowidget()
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
