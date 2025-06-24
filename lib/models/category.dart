class Category {
  String? sId;
  String? name;
  String? image;
  bool isSelected;
  String? createdAt;
  String? updatedAt;

  Category({
    this.sId,
    this.name,
    this.image,
    this.isSelected = false,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json)
      : sId = json['id'].toString(),
        name = json['name'],
        image = json['imagePath'],
        createdAt = json['created'],
        updatedAt = json['updated'],
        isSelected = false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.name;
    data['imagePath'] = this.image;
    data['created'] = this.createdAt;
    data['updated'] = this.updatedAt;
    return data;
  }
}
