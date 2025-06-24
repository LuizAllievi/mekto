import 'variant_type.dart';

class Variant {
  String? sId;
  String? name;
  VariantType? variantTypeId;
  String? created;
  String? updated;

  Variant(
      {this.sId,
        this.name,
        this.variantTypeId,
        this.created,
        this.updated});

  Variant.fromJson(Map<String, dynamic> json) {
    sId = json['id'].toString();
    name = json['name'];
    variantTypeId = json['variantType'] != null
        ? new VariantType.fromJson(json['variantType'])
        : null;
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.name;
    if (this.variantTypeId != null) {
      data['variantType'] = this.variantTypeId!.toJson();
    }
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
