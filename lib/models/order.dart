import 'variant.dart';

class Order {
  ShippingAddress? shippingAddress;
  OrderTotal? orderTotal;
  String? sId;
  UserID? userID;
  String? orderStatus;
  List<Items>? items;
  double? totalPrice;
  String? paymentMethod;
  CouponCode? couponCode;
  String? trackingUrl;
  String? orderDate;
  String? companyName;

  Order(
      {this.shippingAddress,
        this.orderTotal,
        this.sId,
        this.userID,
        this.orderStatus,
        this.items,
        this.totalPrice,
        this.paymentMethod,
        this.couponCode,
        this.trackingUrl,
        this.orderDate,
      this.companyName});

  Order.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['address'] != null
        ? new ShippingAddress.fromJson(json['address'])
        : null;

    final Map<String, dynamic> orderTotalData = new Map<String, dynamic>();
    orderTotalData['subtotal'] = json['subTotal'];
    orderTotalData['discount'] = json['discount'];
    orderTotalData['total'] = json['totalPrice'];
    orderTotal = json['totalPrice'] != null
        ? new OrderTotal.fromJson(orderTotalData)
        : null;
    companyName = json['companyName'];
    sId = json['id'].toString();
    userID =
    json['user'] != null ? new UserID.fromJson(json['user']) : null;

    orderStatus = json['status'].toString().toLowerCase();
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {

        final itema = new Items.fromJson(v);

        items!.add(itema);
      });
    }

    totalPrice = json['totalPrice']?.toDouble();;
    paymentMethod = json['paymentMethod'];

    couponCode = json['coupon'] != null
        ? new CouponCode.fromJson(json['coupon'])
        : null;

    trackingUrl = json['trackingUrl'];
    orderDate = json['orderDate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippingAddress != null) {
      data['address'] = this.shippingAddress!.toJson();
    }

    final orderTotal = this.orderTotal!.toJson();


    if (this.orderTotal != null) {
      data['totalPrice'] = orderTotal['total'];
      data['subtotal'] = orderTotal['subtotal'];
      data['discount'] = orderTotal['discount'];
    }

    data['id'] = this.sId;
    if (this.userID != null) {
      data['user'] = this.userID!.toJson();
    }

    data['status'] = this.orderStatus;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = this.totalPrice;
    data['paymentMethod'] = this.paymentMethod;
    if (this.couponCode != null) {
      data['couponCode'] = this.couponCode!.toJson();
    }
    data['trackingUrl'] = this.trackingUrl;
    data['orderDate'] = this.orderDate;
    data['companyName'] = this.companyName;
    return data;
  }
}

class ShippingAddress {
  String? phone;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? country;

  ShippingAddress(
      {this.phone,
        this.street,
        this.city,
        this.state,
        this.postalCode,
        this.country});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    phone = '';
    street = json['address'];
    city = json['city'];
    state = json['state'];
    postalCode = json['cep'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['cep'] = this.postalCode;
    data['country'] = this.country;
    return data;
  }
}

class OrderTotal {
  double? subtotal;
  double? discount;
  double? total;

  OrderTotal({this.subtotal, this.discount, this.total});

  OrderTotal.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal']?.toDouble();
    discount = json['discount']?.toDouble();
    total = json['total']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['discount'] = this.discount;
    data['total'] = this.total;
    return data;
  }
}

class UserID {
  String? sId;
  String? name;

  UserID({this.sId, this.name});

  UserID.fromJson(Map<String, dynamic> json) {
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

class Items {
  String? productID;
  String? productName;
  int? quantity;
  double? price;
  String? variant;
  String? sId;

  Items(
      {this.productID,
        this.productName,
        this.quantity,
        this.price,
        this.variant,
        this.sId});

  Items.fromJson(Map<String, dynamic> json) {
    productID = json['productId'];
    productName = json['productName'];
    quantity = json['quantity'];
    price = json['price']?.toDouble();

      variant = Variant.fromJson(json['variant']).name;



    sId = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productID;
    data['productName'] = this.productName;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['variant'] = this.variant;
    data['id'] = this.sId;
    return data;
  }
}

class CouponCode {
  String? sId;
  String? couponCode;
  String? discountType;
  int? discountAmount;

  CouponCode(
      {this.sId, this.couponCode, this.discountType, this.discountAmount});

  CouponCode.fromJson(Map<String, dynamic> json) {
    sId = json['id'].toString();
    couponCode = json['couponCode'];
    discountType = json['discountType'];
    discountAmount = json['discountAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['couponCode'] = this.couponCode;
    data['discountType'] = this.discountType;
    data['discountAmount'] = this.discountAmount;
    return data;
  }
}