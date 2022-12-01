import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookInfo();
}

class _BookInfo extends State<BookInfo> {
  List? data;

  @override
  void initState() {
    super.initState();
    data = new List.empty(growable: true);
    getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Hero(tag: 'rabbit', child: Image.asset('images/intro/rabbit.png', width: 100, height: 100,),),
              background: Image.asset('images/intro/carrot.png')
            ),
            pinned: true,
          ),

          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Card(
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Color(0xFFFFE0B2),
                          title: Text(data![index]['title'].toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          subtitle: Text('가격 : ${data![index]['sale_price'].toString()}', style: TextStyle(color: Colors.black),),
                        ),

                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.network(data![index]['thumbnail'],),
                          )
                        )
                      ),
                    );
                  },
                childCount: data!.length
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                childAspectRatio: 8/9
              ),)
        ],
      ),
    );
  }

  Future<String> getJSONData() async {
    var url = "https://dapi.kakao.com/v3/search/book?target=title&query=doit";
    var response = await http.get(Uri.parse(url),
      headers: {"Authorization" : "KakaoAK 499d9b6f188a917a64efe8d7f7c21c6a"});

    setState(() {
      var dataConvertedToJSon = json.decode(response.body);
      List resut = dataConvertedToJSon['documents'];
      data!.addAll(resut);
    });

    return "Sucessfull";
  }
}