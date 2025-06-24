class Coupon {
  String? sId;
  String? couponCode;
  String? discountType;
  double? discountAmount;
  double? minimumPurchaseAmount;
  String? endDate;
  String? status;
  CatRef? applicableCategory;
  CatRef? applicableSubCategory;
  CatRef? applicableProduct;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Coupon(
      {this.sId,
        this.couponCode,
        this.discountType,
        this.discountAmount,
        this.minimumPurchaseAmount,
        this.endDate,
        this.status,
        this.applicableCategory,
        this.applicableSubCategory,
        this.applicableProduct,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Coupon.fromJson(Map<String, dynamic> json) {
    sId = json['id'].toString();
    couponCode = json['couponCode'];
    discountType = json['discountType'];
    discountAmount = json['discountAmount']?.toDouble();
    minimumPurchaseAmount = json['minimumPurchaseAmount']?.toDouble();
    endDate = json['endDate'];
    status = json['status'];
    applicableCategory = json['category'] != null
        ? new CatRef.fromJson(json['category'])
        : null;
    applicableSubCategory = json['subCategory'] != null
        ? new CatRef.fromJson(json['subCategory'])
        : null;
    applicableProduct = json['product'] != null
        ? new CatRef.fromJson(json['product'])
        : null;
    createdAt = json['created'];
    updatedAt = json['updated'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['couponCode'] = this.couponCode;
    data['discountType'] = this.discountType;
    data['discountAmount'] = this.discountAmount;
    data['minimumPurchaseAmount'] = this.minimumPurchaseAmount;
    data['endDate'] = this.endDate;
    data['status'] = this.status;
    if (this.applicableCategory != null) {
      data['category'] = this.applicableCategory!.toJson();
    }
    if (this.applicableSubCategory != null) {
      data['subCategory'] = this.applicableSubCategory!.toJson();
    }
    if (this.applicableProduct != null) {
      data['product'] = this.applicableProduct!.toJson();
    }
    data['created'] = this.createdAt;
    data['updated'] = this.updatedAt;

    return data;
  }
}

class CatRef {
  String? sId;
  String? name;

  CatRef({this.sId, this.name});

  CatRef.fromJson(Map<String, dynamic> json) {
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