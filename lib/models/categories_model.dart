class CategoriesModel {
  late bool status;
  late _CategoriesPage data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = _CategoriesPage.fromJson(json['data']);
  }
}

class _CategoriesPage {
  late int currentPage;
  List<_CategoriesData> data = [];

  _CategoriesPage.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(_CategoriesData.fromJson(element));
    });
  }
}

class _CategoriesData {
  late int id;
  late String name;
  late String image;

  _CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
