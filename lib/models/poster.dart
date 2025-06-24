class Poster {
  String? sId;
  String? posterName;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Poster(
      {this.sId,
        this.posterName,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Poster.fromJson(Map<String, dynamic> json) {
    sId = json['id'].toString();
    posterName = json['name'];
    imageUrl = json['imagePath'];
    createdAt = json['created'];
    updatedAt = json['updated'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.sId;
    data['name'] = this.posterName;
    data['imagePath'] = this.imageUrl;
    data['created'] = this.createdAt;
    data['updated'] = this.updatedAt;

    return data;
  }
}