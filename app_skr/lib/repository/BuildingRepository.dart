import 'dart:convert';
import 'dart:ffi';
import 'package:appskr/models/building_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuildingRepository{
    static String _basicUrl = "192.168.0.153:3000";

  static Future<List<BuildingModel>> getBuildings() async{
    final buildings = <BuildingModel>[];

    try {
      var url = Uri.http(_basicUrl, "/building");
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
      var url = Uri.http(_basicUrl, '/building/$idBuilding');
      final response = await http.get(url);
      return response.body;

    }catch(error){
      return null;
    }
  }

  static Future<List<BuildingModel>> filterBuildings(String category, String type) async{
    print('teste');
    final buildings = <BuildingModel>[];
    try{
      var url = Uri.http(_basicUrl, 'building');
      final response = await http.post(url, body: {
        "category": category,
        "type": type
      });
      print(response.body);
      var json = jsonDecode(response.body);
      for(var building in json){
        //print(building['typeBuilding'] +"  "+building['titleBuilding']+"  "+ building['categoryBuilding']);
        buildings.add(BuildingModel.fromJson(building));
      }
      return buildings;
    }catch(error){
      return null;
    }
  }
}