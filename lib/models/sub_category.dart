import 'category.dart';

class SubCategory {
  String? sId;
  String? name;
  Category? categoryId;
  String? created;
  String? updated;

  SubCategory(
      {this.sId, this.name, this.categoryId, this.created, this.updated});

  SubCategory.fromJson(Map<String, dynamic> json) {
    sId = json['id'].toString();
    name = json['name'];
    categoryId = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.name;
    if (this.categoryId != null) {
      data['category'] = this.categoryId!.toJson();
    }
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
