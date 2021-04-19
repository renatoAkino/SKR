import 'package:appskr/models/building_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:transparent_image/transparent_image.dart';

class BuildingDetailPage extends StatefulWidget {
  final BuildingModel buildingModel;

  const BuildingDetailPage(this.buildingModel);

  @override
  _BuildingDetailPageState createState() => _BuildingDetailPageState();
}

class _BuildingDetailPageState extends State<BuildingDetailPage> {



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      //body: _buildPageContent(),
      body: Stack(
        children: [
          Hero(
            tag: widget.buildingModel.images[0]["urlImage"],
            child: Container(
              height: size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.buildingModel.images[0]["urlImage"]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height* 0.55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  width: size.width * 0.6,
                                  child: Text(
                                    widget.buildingModel.titleBuilding,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.buildingModel.adrressBuilding,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black54
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            switchFilterWidget(widget.buildingModel.typeBuilding)
                          ],
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Descrição",
                                style: TextStyle(
                                    fontSize: 26
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                child: Text(
                                    widget.buildingModel.descBuilding,
                                    style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    GestureDetector(
                                      onTap: () async {
                                        MapsLauncher.launchCoordinates(double.parse(widget.buildingModel.lATbuilding), double.parse(widget.buildingModel.lONGbuilding));
                                      },
                                      child: Container(
                                        height: 75,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  GestureDetector(
                                    onTap: (){
                                      _showDialog(context);
                                    },
                                    child: Container(
                                      height: 75,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.photo,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 30,),
                            ],
                          )
                      ),


                    ],
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  Widget switchFilterWidget(String filter){
    switch(filter){
      case 'residential': return Container(
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.home,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text("Residencial", style: TextStyle(fontSize: 15),)
          ],
        )
      );
      case 'commercial': return Container(
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.work,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Text("Comercial", style: TextStyle(fontSize: 15),)
            ],
          )
      );

    }
  }

  _showDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (_) => Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
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
            pagination: SwiperPagination(),
          ),
        ),
      )
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