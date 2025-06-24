import 'package:mekto/models/sub_category.dart';

class Brand {
  String? sId;
  String? name;
  SubCategory? subcategory;
  String? created;
  String? updated;

  Brand({this.sId, this.name, this.subcategory, this.created, this.updated});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['id'].toString();
    name = json['name'];
    subcategory = json['subCategory'] != null
        ? new SubCategory.fromJson(json['subCategory'])
        : null;
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.name;
    if (this.subcategory != null) {
      data['subCategory'] = this.subcategory!.toJson();
    }
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
