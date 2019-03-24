import 'package:flutter/material.dart';
import 'package:demo/models/product_list.dart';
import 'package:demo/view_models/main_page_view_model.dart';
import 'package:demo/views/widgets/no_internet_connection.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:demo/models//category_data.dart';
import 'package:demo/tab_screens/tab_view.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {


      return FutureBuilder<ProductList>(
        future: model.productlist,
        builder: (_, AsyncSnapshot<ProductList> snapshot){

            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: const CircularProgressIndicator());              
              case ConnectionState.done:
                if (snapshot.hasData) {
                  var films = snapshot.data;
                  return /*ListView.builder(
                    itemCount: films == null ? 0 : films.length,
                    itemBuilder: (_, int index) {
                      var film = films[index];
                      return FilmsListItem(film: film);
                    },
                  );*/

                 Container(

            child:  Column(

              children: <Widget>[
                CarouselSlider(items: getImageViews(snapshot.data)
                  ,autoPlay: true,initialPage: 0,
                  autoPlayDuration: Duration(seconds: 2),
                  aspectRatio: 16/9,
                  viewportFraction: 1.0,
                  reverse: false,
                  pauseAutoPlayOnTouch: Duration(seconds: 1),

                ),

                new Expanded(child:
                new DefaultTabController(length: 3, child: new Scaffold(

                  appBar: TabBar(tabs: getTabs(),unselectedLabelColor: Colors.black,labelColor:
                  Colors.blue,),
                  body: new TabBarView(children: getTabViews(films.response.data.categoryData)),
                )

                ),
                )


              ],


            ),

          );
                } else if (snapshot.hasError) {
                  return NoInternetConnection(
                    action: () async {
                      await model.setProduct();
                    },
                  );
                }
            }
          },
        );
      },
    );
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

}