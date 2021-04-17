import 'dart:convert';
import 'package:appskr/models/building_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuildingRepository{
  static Future<List<BuildingModel>> getBuildings() async{
    final buildings = <BuildingModel>[];

    try {
      var url = Uri.http("192.168.0.153:3000", "/building");
      final response = await http.get(url);
      var json = jsonDecode(response.body);
      for(var building in json){
          buildings.add(BuildingModel.fromJson(building));
      }
      return buildings;
    }catch(error){
      return null;
    }

  }

  static Future<String> getImage(String idBuilding) async{
    try{
      var url = Uri.http('192.168.0.153:3000', '/building/$idBuilding');
      final response = await http.get(url);
      return response.body;

    }catch(error){
      return null;
    }
  }
}