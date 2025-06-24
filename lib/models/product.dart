import 'package:flutter/widgets.dart';

class Product {
  String? sId;
  String? name;
  String? description;
  int? quantity;
  double? price;
  double? offerPrice;
  ProRef? proCategoryId;
  ProRef? proSubCategoryId;
  ProRef? proBrandId;
  ProTypeRef? proVariantTypeId;
  List<ProRef>? proVariantId;
  List<Images>? images;
  String? companyName;
  String? createdAt;
  String? updatedAt;


  Product(
      {this.sId,
        this.name,
        this.description,
        this.quantity,
        this.price,
        this.offerPrice,
        this.proCategoryId,
        this.proSubCategoryId,
        this.proBrandId,
        this.proVariantTypeId,
        this.proVariantId,
        this.images,
        this.companyName,
        this.createdAt,
        this.updatedAt,
      });

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['id'].toString();
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price']?.toDouble();;
    offerPrice = json['offerPrice']?.toDouble();;
    proCategoryId = json['category'] != null
        ? new ProRef.fromJson(json['category'])
        : null;
    proSubCategoryId = json['subCategory'] != null
        ? new ProRef.fromJson(json['subCategory'])
        : null;
    proBrandId = json['brand'] != null
        ? new ProRef.fromJson(json['brand'])
        : null;
    proVariantTypeId = json['variantType'] != null
        ? new ProTypeRef.fromJson(json['variantType'])
        : null;
    proVariantId = (json['variants'] as List).map((item) => ProRef.fromJson(item)).toList();
    if (json['imagesPaths'] != null) {
      images = (json['imagesPaths'] as List).map((item) => Images.fromJson(item)).toList();
    }
    createdAt = json['created'];
    updatedAt = json['updated'];
    companyName = json['companyName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['offerPrice'] = this.offerPrice;
    if (this.proCategoryId != null) {
      data['category'] = this.proCategoryId!.toJson();
    }
    if (this.proSubCategoryId != null) {
      data['subCategory'] = this.proSubCategoryId!.toJson();
    }
    if (this.proBrandId != null) {
      data['brand'] = this.proBrandId!.toJson();
    }
    if (this.proVariantTypeId != null) {
      data['variantType'] = this.proVariantTypeId!.toJson();
    }
    data['variants'] = this.proVariantId;
    if (this.images != null) {
      data['imagesPaths'] = this.images!.map((v) => (v.toJson())).toList();
    }
    data['created'] = this.createdAt;
    data['updated'] = this.updatedAt;

    return data;
  }
}

class ProRef {
  String? sId;
  String? name;

  ProRef({this.sId, this.name});

  ProRef.fromJson(Map<String, dynamic> json) {
    sId = json['id'].toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Images {
  String? path;
  String? position;

  Images({this.path, this.position});

  Images.fromJson(Map<String, dynamic> json) {
    path = json['path'].toString();
    position = json['position'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['position'] = this.position;
    return data;
  }
}
class ProTypeRef {
  String? sId;
  String? type;

  ProTypeRef({this.sId, this.type});

  ProTypeRef.fromJson(Map<String, dynamic> json) {
    sId = json['id'].toString();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['type'] = this.type;
    return data;
  }
}
