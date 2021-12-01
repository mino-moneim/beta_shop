class SearchModel {
  bool? status;
  late Data data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<SearchData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(SearchData.fromJson(element));
    });
  }
}

class SearchData {
  late int id;
  late dynamic price;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
