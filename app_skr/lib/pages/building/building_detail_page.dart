import 'package:appskr/models/building_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BuildingDetailPage extends StatefulWidget {
  final BuildingModel buildingModel;

  const BuildingDetailPage(this.buildingModel);

  @override
  _BuildingDetailPageState createState() => _BuildingDetailPageState();
}

class _BuildingDetailPageState extends State<BuildingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Container(
                  height: 300,
                  padding: EdgeInsets.all(16.0),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(widget.buildingModel.images[index]['urlImage']), fit: BoxFit.fill)),
                        ),
                      );
                    },
                    itemWidth: 300,
                    itemCount: widget.buildingModel.images.length,
                    layout: SwiperLayout.STACK,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.buildingModel.titleBuilding,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.buildingModel.descBuilding,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}