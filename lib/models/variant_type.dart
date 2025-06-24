class VariantType {
  String? name;
  String? type;
  String? sId;
  String? created;
  String? updated;

  VariantType(
      {this.name,
        this.type,
        this.sId,
        this.created,
        this.updated,
      });

  VariantType.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    sId = json['id'].toString();
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['id'] = this.sId;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}