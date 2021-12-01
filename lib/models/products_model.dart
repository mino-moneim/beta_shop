class HomeModel {
  late bool status;
  late _HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = _HomeDataModel.fromJson(json['data']);
  }
}

class _HomeDataModel {
  List<_BannersModel> banners = [];
  List<ProductsModel> products = [];

  _HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((banner) {
      banners.add(_BannersModel.fromJson(banner));
    });

    json['products'].forEach((product) {
      products.add(ProductsModel.fromJson(product));
    });
  }
}

class _BannersModel {
  late int id;
  late String image;

  _BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
