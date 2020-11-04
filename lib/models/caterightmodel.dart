class CateRightModel {
  List<CateRightItemModel> result;

  CateRightModel({this.result});

  CateRightModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<CateRightItemModel>();
      json['result'].forEach((v) {
        result.add(new CateRightItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CateRightItemModel {
  String sId;
  String title;
  String status;
  String pic;
  String pid;
  String sort;

  CateRightItemModel({this.sId, this.title, this.status, this.pic, this.pid, this.sort});

  CateRightItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pid = json['pid'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['pid'] = this.pid;
    data['sort'] = this.sort;
    return data;
  }
}