import 'package:demo/model/category_data.dart';
import 'package:demo/model/product_list.dart';
import 'package:demo/tab_screens/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' ;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),

      home: new DashboardPage("Home"),
    );
  }
}


class DrawerItem{

  String title;

  DrawerItem(this.title);
}

class DashboardPage extends StatefulWidget{


  String title;

  DashboardPage(this.title);

  @override
  State createState() {

    return new DashboardState();
  }
}


class DashboardState extends State<DashboardPage>{


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
          child: new Column(
              children: <Widget>[
                new DrawerHeader(
                  child: Image.asset('assets/invite_friends_pic.png'),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                ),
                new Column( children: drawerOptions),
//      new Column(children: <Widget>[
//      getListView(),
//      ]
//      ),
              ]),

        ),
        /*  drawer: Drawer(

      child: Column(


        children: <Widget>[

          UserAccountsDrawerHeader(accountName: Text("Nafeez Diamond"), accountEmail: null),
          Column(children: drawerOptions,)
        ],
      ),

    ),*/


        body:

        Center(

          child: Container(

            child: FutureBuilder<ProductList>(
                future: getFromApi(),
                builder: (BuildContext context, AsyncSnapshot<ProductList> snapshot){
                  return snapshot.connectionState == ConnectionState.done?
                  snapshot.hasData? Column(



                    children: <Widget>[


                      new Container(

                        height: 200.00,
                        padding: EdgeInsets.all(3.00),
                        child: PageView(
                            pageSnapping: true,
                            children:getImageViews(snapshot.data)

                        ),

                      ),

                      new Expanded(child:
                      new DefaultTabController(length: 3, child: new Scaffold(

                        appBar: TabBar(tabs: getTabs(),unselectedLabelColor: Colors.black,labelColor:
                        Colors.blue,),
                        body: new TabBarView(children: getTabViews(snapshot.data.response.data.categoryData)),
                      )),)


                    ],


                  ):

                  InkWell(

                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text("ERROR OCCURRED, Tap to retry !"),
                    ),

                  )
                      :CircularProgressIndicator();

                }




            ),

          ),

        )

    );

  }


  void onSelect(int i){

    setState(() {

      widget.title = drawerItems[i].title;
      selectedIndex = i;
      Navigator.of(context).pop();

    });

  }

  List<Widget> getTabs(){

    return <Widget>[

      Tab(text: "Diamond"),
      Tab(text: "Gold"),
      Tab(text: "Silver"),

    ];
  }

  List<Widget> getTabViews( List<CategoryData> categoryData){


    return <Widget>[

      new Fragment(categoryData[0].childData),
      new Fragment(categoryData[1].childData),
      new Fragment(categoryData[2].childData)
    ];
  }


  Future <ProductList> getFromApi() async{


    var resp = await get(url);
    if(resp.statusCode==200){

      return getProductFromjson(resp.body);
    }else
      throw Exception("Failed to load data");

  }

  ProductList getProductFromjson(String str){

    final json = jsonDecode(str);
    return ProductList.fromJson(json);

  }



  List<Widget> getImageViews(ProductList pl){

    int size = pl.response.data.banner.length;
    List<Widget> l = new List<Widget>();

    for(int i =0;i<size;i++){

      l.add(Container(child:Image.network("${pl.response.data.banner[i].image}",
        fit: BoxFit.fill,
        scale: 1.0,repeat: ImageRepeat.noRepeat,),));
    }

    return l;
  }


}