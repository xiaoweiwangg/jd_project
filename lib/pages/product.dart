import 'package:flutter/material.dart';
import '../service/api.dart';
import "package:dio/dio.dart";
import 'dart:convert';
import 'package:jd_project/models/productmodel.dart';
import '../widget/LoadingWidget.dart';
class ProductPage extends StatefulWidget {
  Map arguments;
  ProductPage({this.arguments});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String api = Config.api;
  List plist = [];
  ScrollController _scrollController = new ScrollController();
  int pageindex = 1;
  int pagesize = 8;
  bool flag = true;
  bool hasmore = true;
  @override
  initState() {
    super.initState();
    this.getProductlist();
    this._scrollController.addListener(() {
      if (this._scrollController.position.pixels >
          this._scrollController.position.maxScrollExtent-20) {
        if (this.flag && this.hasmore) {
          this.getProductlist();
        }
      }
    });
  }

//获取数据
  getProductlist() async {
    setState(() {
      this.flag = false;
    });
    var data = await Dio().get(
        '${api}api/plist?cid=${widget.arguments['cid']}&page=${this.pageindex}&pageSize=${this.pagesize}');
    print(this.pageindex);
    print(ProductModel.fromJson(json.decode(data.toString())).result.length);
    setState(() {
      this
          .plist
          .addAll(ProductModel.fromJson(json.decode(data.toString())).result);
      if (ProductModel.fromJson(json.decode(data.toString())).result.length <
          this.pagesize) {
        this.hasmore = false;
        print('没有更多了');
      }
      this.pageindex++;
      this.flag = true;
    });
  }
Widget isloading(){
// if()
}
  Widget _prolist() {
    if (this.plist.length > 0) {
      return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.all(0),
        child: ListView.builder(
            controller: this._scrollController,
            itemCount: this.plist.length,
            itemBuilder: (context, index) {
              String pic = this.plist[index].pic;
              var img = pic.replaceAll('\\', '/');
              return Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            '${api + img}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${this.plist[index].title}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('￥${this.plist[index].price}')
                                    ],
                                  ),
                                )))
                      ],
                    ),
                    Divider()
                  ],
                ),
              );
            }),
      );
    } else {
      return LoadingWidget();
    }
  }

  Widget _topbanner() {
    return Container(
      height: 40,
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: Text(
                    '售价',
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: Text(
                    '地区',
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: Text(
                    '销量',
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  _scaffoldKey.currentState.openEndDrawer();
                },
                child: Container(
                  child: Text(
                    '筛选',
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('list pro'),
        ),
        endDrawer: Drawer(
          child: Container(
            child: Center(
              child: Text("筛选"),
            ),
          ),
        ),
        body: Stack(
          children: [this._prolist(), this._topbanner()],
        ));
  }
}
