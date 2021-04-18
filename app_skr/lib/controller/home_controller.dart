import 'dart:convert';
import 'package:appskr/models/building_model.dart';
import 'package:appskr/repository/BuildingRepository.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class HomeController{
  List<BuildingModel> buildings = [];
  final repository = BuildingRepository();
  final state = ValueNotifier<HomeState>(HomeState.start);


  Future<void> init() async{

    state.value = HomeState.loading;
    try{
      buildings = await BuildingRepository.getBuildings();
      await getImage();
      await getAdrress();
      state.value = HomeState.success;
    }catch(error){
      state.value = HomeState.error;
    }
  }

  Future<void>getImage() async{
    for(BuildingModel building in buildings){
      String images = await BuildingRepository.getImage(building.idBuilding.toString());
      building.images = jsonDecode(images);
    }
  }

  Future<void> changeFilter(String category, String type) async{
    state.value = HomeState.loading;
    try{
      buildings = await BuildingRepository.filterBuildings(category, type);
      await getImage();
      await getAdrress();
      state.value = HomeState.success;
    }catch(error){
      state.value = HomeState.error;
    }
  }

  Future<String> getAdrress() async{
    for(BuildingModel building in buildings){
      var addresses = await placemarkFromCoordinates(double.parse(building.lATbuilding), double.parse(building.lONGbuilding));
      building.adrressBuilding = addresses.first.thoroughfare;
    }
  }
}



enum HomeState {start, loading, success, error}