class ProductListModel {
  int? id;
  String? title;
  String? content;
  String? image;
  String? thumbnail;
  int? userId;

  ProductListModel({
    this.id,
    this.title,
    this.content,
    this.image,
    this.thumbnail,
    this.userId,
  });

  ProductListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    data['thumbnail'] = thumbnail;
    data['userId'] = userId;
    return data;
  }
}
