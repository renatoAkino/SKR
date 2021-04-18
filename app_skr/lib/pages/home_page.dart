import 'package:appskr/controller/home_controller.dart';
import 'package:appskr/models/building_model.dart';
import 'package:appskr/pages/building/building_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  String _typeFilter = "any";
  String _categoryFilter = "any";

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  void dispose() {
    controller.state.dispose();
    _typeFilter = "any";
    _categoryFilter = "any";

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SKR Empreendimentos", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        shape: ContinuousRectangleBorder(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(45.0),
            bottomRight: Radius.circular(45.0)
          ),),
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child){
          return stateManagement(controller.state.value);
        },
      ),

    );
  }

  stateManagement(HomeState state){
    switch(state){
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      case HomeState.error:
        return _error();

    }
  }

  _success() {
    return Container(
      padding: EdgeInsets.all(10),
      child:  Column(
        children: [
          filterBarWidget(), //Widget com os filtros

          Padding(
            padding: EdgeInsets.only(right: 24, left: 24, top: 5, bottom: 16),
            child: Row(
              children: [
                Text(
                  controller.buildings.length.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  width: 8,
                ),

                Text(
                  "Resultados encontrados",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

              ],
            ),
          ), //Numero de Resultados encontrados

          Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: controller.buildings.map((build){
                  return Hero(
                    tag: build.images[0]["urlImage"],
                    child: buildCard(build),
                  );
                }).toList(),
              )
          )
          /*Expanded(
            child: StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 2,
              itemCount: controller.buildings.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Image.network(controller.buildings[index].images[0]['urlImage'], fit: BoxFit.cover,),
                      Text(controller.buildings[index].titleBuilding),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context){
                      return(BuildingDetailPage(controller.buildings[index]));
                    })
                  );

                },
              ),
              staggeredTileBuilder: (int index){
                return StaggeredTile.count(1, 2);
              },
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
          ),)*/

    ]  ),

    );
  }

  _start() {
    return Container();
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.init();
          _categoryFilter = null;
          _typeFilter = null;
        },
        child: Text("Tentar Novamente"),
      ),
    );
  }

  Widget filterBarWidget(){
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            child: Container(
              height: 32,
              child: Stack(
                children: [

                  ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [

                      SizedBox(
                        width: 24,
                      ),
                      GestureDetector(
                        child: buildFilter("Comercial", _typeFilter == 'commercial' ? Colors.black12 : Colors.white),
                        onTap: (){
                          if(_typeFilter == 'commercial'){
                            setState(() {
                              _typeFilter = "any";
                            });
                            if(_categoryFilter == "any" && _typeFilter == "any"){
                              controller.init();
                            }else{
                              controller.changeFilter(_categoryFilter, _typeFilter);
                            }
                          }else{
                            setState(() {
                              _typeFilter = 'commercial';
                            });
                            controller.changeFilter(_categoryFilter, _typeFilter);
                          }
                        }
                      ),
                      GestureDetector(
                        child: buildFilter("Residencial", _typeFilter == 'residential' ? Colors.black12 : Colors.white),
                        onTap: (){
                          if(_typeFilter == 'residential'){
                            setState(() {
                              _typeFilter = "any";
                            });
                            if(_categoryFilter == "any" && _typeFilter == "any"){
                              controller.init();
                            }else{
                              controller.changeFilter(_categoryFilter, _typeFilter);
                            }
                          }else{
                            setState(() {
                              _typeFilter = 'residential';
                            });
                            controller.changeFilter(_categoryFilter, _typeFilter);
                          }
                        },
                      ),
                      GestureDetector(
                        child: buildFilter("Lançamentos", _categoryFilter == 'realise' ? Colors.black12 : Colors.white),
                        onTap: (){
                          if(_categoryFilter == 'realise'){
                            setState(() {
                              _categoryFilter = "any";
                            });
                            if(_categoryFilter == "any" && _typeFilter == "any"){
                              controller.init();
                            }else{
                              controller.changeFilter(_categoryFilter, _typeFilter);
                            }
                          }else{
                            setState(() {
                              _categoryFilter = 'realise';
                            });
                            controller.changeFilter(_categoryFilter, _typeFilter);
                          }

                        },
                      ),
                      GestureDetector(
                        child: buildFilter("Entregues", _categoryFilter == 'conclude' ? Colors.black12 : Colors.white),
                        onTap: (){
                          if(_categoryFilter == 'conclude'){
                            setState(() {
                              _categoryFilter = "any";
                              print(_categoryFilter + "  " + _typeFilter);
                            });
                            if(_categoryFilter == "any" && _typeFilter == "any"){
                              controller.init();
                            }else{
                              controller.changeFilter(_categoryFilter, _typeFilter);
                            }
                          }else{
                            setState(() {
                              _categoryFilter = 'conclude';
                            });
                            controller.changeFilter(_categoryFilter, _typeFilter);
                          }
                        },
                      ),




                      SizedBox(
                        width: 8,
                      ),

                    ],
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 28,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Theme.of(context).scaffoldBackgroundColor,
                            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          GestureDetector(
            onTap: (){
              setState(() {
                _categoryFilter = 'any';
                _typeFilter = 'any';
                controller.init();
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 24),
              child: Text(
                "Filtros",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildFilter(String filterName, Color color){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(
            color: Colors.grey[300],
            width: 1,
          )
      ),
      child: Center(
        child: Text(
          filterName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildingModel build) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return(BuildingDetailPage(build));
            })
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 24),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(build.images[0]['urlImage']),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(),
                ),

                Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          build.titleBuilding,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          swtichFilter(build.typeBuilding),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),

                    SizedBox(
                      height: 4,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Row(
                          children: [

                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 14,
                            ),

                            SizedBox(
                              width: 4,
                            ),

                            Text(
                              build.adrressBuilding,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),

                            SizedBox(
                              width: 8,
                            ),


                          ],
                        ),

                        Row(
                          children: [


                            Text(
                              swtichFilter(build.categoryBuilding),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  String swtichFilter(String filter){
    switch(filter){
      case 'residential': return 'Residencial';
      case 'commercial': return 'Comercial';
      case 'conclude': return 'Entregue';
      case 'realise': return 'Lançamentos';

    }
  }
}
