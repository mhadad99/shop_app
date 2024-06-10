class CategoryModel {
  bool? status;
  DataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<CatDataModel> data = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((e) {
      data.add(CatDataModel.fromJson(e));
    });
  }
}

class CatDataModel {
  late int id;
  late String name;
  late String image;

  CatDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
