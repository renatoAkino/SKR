import 'package:appskr/controller/home_controller.dart';
import 'package:appskr/repository/BuildingRepository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
