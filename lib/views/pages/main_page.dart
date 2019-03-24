import 'dart:async';
import 'package:flutter/material.dart';
import 'package:demo/view_models/main_page_view_model.dart';
import 'package:demo/views/widgets/dashboard_panel.dart';
import 'package:scoped_model/scoped_model.dart';

class MainPage extends StatefulWidget {
  final MainPageViewModel viewModel;
  String title;
  MainPage({Key key, @required this.viewModel}) : super(key: key);


  @override
  State createState() {

    return new DashboardState();
  }
}

Future loadData() async {

  await widget.viewModel.setProduct();

}



//@override
//void initState() {
//  super.initState();
//  loadData();
//}


class DrawerItem{

  String title;

  DrawerItem(this.title);
}



class DashboardState extends State<MainPage>{


  String url ="https://ndjtest.com/mobileapi/index/index";
  int selectedIndex = 0;
  final drawerItems = [
    DrawerItem("Home"),
    DrawerItem("Diamond"),
    DrawerItem("Gold"),
    DrawerItem("Silver"),
    DrawerItem("Offers"),
    DrawerItem("My Profile"),
    DrawerItem("What's New"),
    DrawerItem("Events"),
    DrawerItem("Currency"),
    DrawerItem("My Orders"),
    DrawerItem("Wish List"),
    DrawerItem("Invite Friends"),
    DrawerItem("About Us"),
    DrawerItem("Contact Us"),
    DrawerItem("Settings"),
  ];

  @override
  Widget build(BuildContext context){


    var drawerOptions = <Widget>[];

    for(int i = 0 ;i < drawerItems.length ; i++){
      var d  = drawerItems[i];
      drawerOptions.add(

          ListTile(title: new Text(d.title,textAlign: TextAlign.center,),
            subtitle : new Divider( color: Colors.grey),
            selected:i==selectedIndex ,onTap: (){

              onSelect(i);

            },)
      );

    }

    return new Scaffold(

        appBar: AppBar(

          title: Text(widget.title),
          centerTitle: true,

        ),

        drawer: new Drawer(

          child: ListView(

            children: <Widget>[

              new DrawerHeader(
                  child: Image.asset('assets/invite_friends_pic.png'),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  )
              ),
              new Column( children: drawerOptions)

            ],
          ),

        ),


        body: ScopedModel<MainPageViewModel>(
    model: widget.viewModel,
      child:  DashboardPanel(),
    ),






    );

  }


  void onSelect(int i){

    setState(() {

      widget.title = drawerItems[i].title;
      selectedIndex = i;
      Navigator.of(context).pop();

    });

  }


}





/*

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController tabController;

  Future loadData() async {
    await widget.viewModel.setProduct();
    await widget.viewModel.setCharacters();
    await widget.viewModel.setPlanets();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Star Wars',
          style: TextStyle(
            fontFamily: 'Distant Galaxy',
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          tabs: <Widget>[
            Tab(icon: Icon(FontAwesomeIcons.film)),
            Tab(icon: Icon(FontAwesomeIcons.users)),
            Tab(icon: Icon(FontAwesomeIcons.globeAmericas))
          ],
        ),
      ),
      body: ScopedModel<MainPageViewModel>(
        model: widget.viewModel,
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            FilmsPanel(),
            CharactersPanel(),
            PlanetsPanel(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}*/
