import 'package:flutter/material.dart';
import 'package:newsapp/jsonclass.dart';

class MoreDetails extends StatelessWidget {
  final List<Article>  newsResponsees;
  MoreDetails({Key key, this.newsResponsees}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: new EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount:newsResponsees.length,
        itemBuilder: (context,index){
          return Card(
              elevation: 5.0,
              child: Column(
                children: <Widget>[
                  Image.network(newsResponsees[index].urlToImage),
                  Text(newsResponsees[index].title,style: TextStyle(fontSize: 36,color: Colors.black,fontWeight:FontWeight.bold)),
                  Text(newsResponsees[index].description),
                  Divider(thickness: 2),
                  Text(newsResponsees[index].content),
                  Text("Source",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(newsResponsees[index].source.name),
                ],
              )
          );
        });
  }
}
