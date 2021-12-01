class FavoritesModel {
  late bool status;
  late _FavoritesData data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = _FavoritesData.fromJson(json['data']);
  }
}

class _FavoritesData {
  late int currentPage;
  List<_FavData> data = [];

  _FavoritesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(_FavData.fromJson(element));
    });
  }
}

class _FavData {
  late int id;
  late ProductModel product;

  _FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
