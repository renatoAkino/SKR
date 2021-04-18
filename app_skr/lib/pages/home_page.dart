import 'package:appskr/controller/home_controller.dart';
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
          filterBarWidget(),


          Expanded(
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
          ),)

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

  filterBarWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
          children: [
              Row(
              children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: _typeFilter == 'commercial' ? Theme.of(context).primaryColor : Colors.white,
                          onPrimary: _typeFilter == 'commercial' ? Colors.white : Theme.of(context).primaryColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18)
                          ),
                          side: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                      onPressed: (){
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
                      },
                      child: Text("Comercial".toUpperCase(),),
                  ),
                SizedBox(width: 10),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: _typeFilter == 'residential' ? Theme.of(context).primaryColor : Colors.white,
                      onPrimary: _typeFilter == 'residential' ? Colors.white : Theme.of(context).primaryColor,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18)
                      ),
                      side: BorderSide(color: Theme.of(context).primaryColor)
                  ),
                  onPressed: (){
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
                  child: Text("Residencial".toUpperCase(),),
                ),
                SizedBox(width: 10),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: _categoryFilter == 'realise' ? Theme.of(context).primaryColor : Colors.white,
                      onPrimary: _categoryFilter == 'realise' ? Colors.white : Theme.of(context).primaryColor,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18)
                      ),
                      side: BorderSide(color: Theme.of(context).primaryColor)
                  ),
                  onPressed: (){
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
                  child: Text("Lançamentos".toUpperCase(),),
                ),
                SizedBox(width: 10),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: _categoryFilter == 'conclude' ? Theme.of(context).primaryColor : Colors.white,
                      onPrimary: _categoryFilter == 'conclude' ? Colors.white : Theme.of(context).primaryColor,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18)
                      ),
                      side: BorderSide(color: Theme.of(context).primaryColor)
                  ),
                  onPressed: (){
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
                  child: Text("Entregues".toUpperCase(),),
                ),
                  ],
              ),
      ],
      )
    ,
    );
  }
}
