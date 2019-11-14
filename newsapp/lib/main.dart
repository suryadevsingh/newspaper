import 'package:flutter/material.dart';
import 'package:newsapp/MoreDetails.dart';
import 'package:newsapp/apiresponse.dart';
import 'package:newsapp/bloc.dart';
import 'package:newsapp/jsonclass.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Articlesbloc _bloc ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Articles app"),),
        body: RefreshIndicator(
          onRefresh: ()=> _bloc.fetchArticlesbloc(),
          child: StreamBuilder<ApiResponse<NewsResponse>>(

            stream:_bloc.streamData,
            builder: (context, snapshot){
              if (snapshot.hasData){
                switch (snapshot.data.status){
                  case Status.LOADING:
                    return Loading(loadingMessage: snapshot.data.message);
                  break;
                    case Status.COMPLETED:
                    return ArticlesScreen(newsResponsees: snapshot.data.data.articles);
                    break;
                  case Status.ERROR:
                    return Error(
                      errorMessage: snapshot.data.message,
                      onRetryPressed:()=> _bloc.fetchArticlesbloc()
                    );
                    break;
                }
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _bloc = Articlesbloc();
    _bloc.fetchArticlesbloc();
  }

  @override
  void dispose() {

    super.dispose();
  }
}

class ArticlesScreen extends StatelessWidget{
  final List<Article>  newsResponsees;
  ArticlesScreen({Key key, this.newsResponsees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      shrinkWrap: true,
        itemCount:newsResponsees.length,
        itemBuilder: (context,index){
          return Card(
            elevation: 5.0,
            child: Column(
              children: <Widget>[
                Image.network(newsResponsees[index].urlToImage),
                Text(newsResponsees[index].title,style: TextStyle(fontSize: 26,color: Colors.black,fontWeight:FontWeight.bold)),
              Text(newsResponsees[index].description),
                MaterialButton(
                  child: Text("Get more details"),
                  onPressed: (){
                    Navigator.push(context,  MaterialPageRoute(builder: (context) => MoreDetails(newsResponsees: newsResponsees,)));
                  },)


              ],
            )
          );
        });
  }
}


class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
