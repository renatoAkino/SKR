import 'dart:convert';

import 'package:appskr/models/building_model.dart';
import 'package:appskr/repository/BuildingRepository.dart';

class HomeController{
  List<BuildingModel> buildings = [];
  final repository = BuildingRepository();
  HomeState state = HomeState.start;


  init() async{

    state = HomeState.loading;
    try{
      buildings = await BuildingRepository.getBuildings();
      getImage();
      state = HomeState.success;
    }catch(error){
      state = HomeState.error;
    }
  }

  getImage() async{
    for(BuildingModel building in buildings){
      String images = await BuildingRepository.getImage(building.idBuilding.toString());
      building.images = jsonDecode(images);
      print(building.images);
    }
  }
}

enum HomeState {start, loading, success, error}