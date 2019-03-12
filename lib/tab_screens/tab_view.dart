import 'package:demo/model/children_data.dart';
import 'package:flutter/material.dart';


class Fragment extends StatelessWidget{

  List<ChildrenData> childrenData;


  Fragment(this.childrenData);

  @override
  Widget build(BuildContext context) {

    return  ListView.builder(

      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: <Widget>[
              Text(
                ("${childrenData[index].name}"),
                /*  style: Theme.of(context).textTheme.body2,*/
              ),

              Container(

                height: 100.0,
                child: new ListView(

                        scrollDirection: Axis.horizontal,
                        children: new List.generate(childrenData[index].itemList.length, (int pos) {
                          return new Card(
                            color: Colors.blue[pos * 100],
                            child: new Container(
                              width: 90.0,
                              height: 90.0,
                              child: new Image.network(("${childrenData[index].itemList[pos].image}"), fit: BoxFit.cover),
                            ),
                          );
                        }),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: childrenData.length,
    );
    // );
  }

}
//}