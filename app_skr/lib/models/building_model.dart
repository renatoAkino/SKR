

class BuildingModel {
  int idBuilding;
  String titleBuilding;
  String typeBuilding;
  String descBuilding;
  String categoryBuilding;
  String lATbuilding;
  String lONGbuilding;
  List<dynamic> images;
  String adrressBuilding;

  BuildingModel(
      {this.idBuilding,
        this.titleBuilding,
        this.typeBuilding,
        this.descBuilding,
        this.categoryBuilding,
        this.lATbuilding,
        this.lONGbuilding});

  BuildingModel.fromJson(Map<String, dynamic> json) {
    idBuilding = json['idBuilding'];
    titleBuilding = json['titleBuilding'];
    typeBuilding = json['typeBuilding'];
    descBuilding = json['descBuilding'];
    categoryBuilding = json['categoryBuilding'];
    lATbuilding = json['LATbuilding'];
    lONGbuilding = json['LONGbuilding'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idBuilding'] = this.idBuilding;
    data['titleBuilding'] = this.titleBuilding;
    data['typeBuilding'] = this.typeBuilding;
    data['descBulding'] = this.descBuilding;
    data['categoryBuilding'] = this.categoryBuilding;
    data['LATbuilding'] = this.lATbuilding;
    data['LONGbuilding'] = this.lONGbuilding;
    return data;
  }
}
