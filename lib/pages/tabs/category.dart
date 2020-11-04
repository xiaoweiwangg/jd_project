import 'package:flutter/material.dart';
import 'package:jd_project/models/cateleftmodel.dart';
import 'package:jd_project/models/caterightmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//api
import '../../service/api.dart';
//数据请求库
import 'package:dio/dio.dart';
import 'dart:convert';

class CategoryCont extends StatefulWidget {
  @override
  _CategoryContState createState() => _CategoryContState();
}

class _CategoryContState extends State<CategoryCont>
    with AutomaticKeepAliveClientMixin {
  int _selectindex = 0;
  List _leftlist = [];
  List<Widget> _rightlist = [];
//获取左侧列表数据
  void getleftdata() async {
    var data = await Dio().get(Config.api + 'api/pcate');
    // print(data);
    print(Config.api + 'api/pcate');
    setState(() {
      this._leftlist =
          CateLeftModel.fromJson(json.decode(data.toString())).result;
      this.getrightdata(this._leftlist[this._selectindex].sId);
    });
  }

//获取右侧数据
  void getrightdata(pid) async {
    String api = '${Config.api}api/pcate?pid=${pid}';
    var data = await Dio().get(api);
    var ls = CateRightModel.fromJson(json.decode(data.toString())).result;
    setState(() {
      this._rightlist = ls.map((e) {
        return _SingleProWidget(e);
      }).toList();
    });
    print(data);
  }
//商品单个组件

  Widget _SingleProWidget(product) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product' ,arguments: {
          "cid":product.sId
        });
      },
      child: Container(
        width: ((1.sw - 1.sw / 4) - 16.w * 2) / 3,
        // margin: EdgeInsets.all(2.w),
        // decoration: BoxDecoration(color: Colors.amber),
        child: Column(
          children: [
            Image.network('${Config.api}${product.pic.replaceAll('\\', '/')}'),
            Text(product.title)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    double leftwidth = 1.sw / 4;
    double rightwidth = 1.sw - 1.sw / 4 - 16.w * 2;
    double rightheight = rightwidth + 150.h;
    if (this._leftlist.length > 0) {
      return Container(
        height: double.infinity,
        child: Row(
          children: [
            Container(
              color: Colors.black12,
              height: double.infinity,
              width: leftwidth,
              child: ListView.builder(
                  itemCount: this._leftlist.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              this._selectindex = index;
                              this.getrightdata(this._leftlist[index].sId);
                            });
                          },
                          child: Container(
                            height: 50,
                            color: this._selectindex == index
                                ? Colors.white
                                : Colors.black12,
                            child: Center(
                              child: Text('${this._leftlist[index].title}'),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16.w),
                height: double.infinity,
                color: Colors.white,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: this._rightlist,
                ),
                //   child: GridView.builder(
                //       itemCount: this._rightlist.length,
                //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         childAspectRatio: rightwidth / rightheight,
                //         crossAxisCount: 3,
                //         mainAxisSpacing: 10.h
                //       ),
                //       itemBuilder: (context, index) {
                //         return Container(
                //           child: Column(
                //             children: [
                //               AspectRatio(
                //                 aspectRatio: 1 / 1,
                //                 child: Image.network(
                //                     '${Config.api}${this._rightlist[index].pic.replaceAll('\\', '/')}'),
                //               ),
                //               Container(
                //                 height: 50.h,
                //                 child: Text(this._rightlist[index].title),
                //               )
                //             ],
                //           ),
                //         );
                //       }),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        width: 140,
        child: Text('loading...'),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getleftdata();
    // this.getrightdata('59f1e4659bfd8f3bd030eed3');
    print('category initstate ....');
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
