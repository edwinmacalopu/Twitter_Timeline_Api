import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:twitter_timeline/src/services/Apitwitter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() { 
    super.initState();
    Apitwitter().getTwitterTimeline();
  }
  @override
  Widget build(BuildContext context) {
    return Container(      
       height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.height,
       padding: EdgeInsets.symmetric(vertical: 10),
       margin: EdgeInsets.all(20),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),
          color: Colors.white,
       ),
      child: FutureBuilder(
        future: Apitwitter().getTwitterTimeline(),
         initialData: 0,
         builder: (BuildContext context, AsyncSnapshot snapshot) {
           switch(snapshot.connectionState){
              case ConnectionState.none:
              return Center(child:Text('SIN CONEXIÓN'));
              case ConnectionState.waiting:
                //return Center(child:Container());
              case ConnectionState.active:
              return  Center(child: CircularProgressIndicator());
              case ConnectionState.done:
              if (snapshot.hasError) return Text("ocurrio un error:${snapshot.error}"); 
              var met=snapshot.data;
             return ListView.separated( 
               itemCount: met.length,
                separatorBuilder: (BuildContext context, int index) => Divider(),
               itemBuilder: (context,index){                    
                  String url;
                  var currentDate =Jiffy(met[index]['created_at'].toString().replaceAll('+0000',''),'EEE MMM dd hh:mm:ss  yyyy')..startOf(Units.DAY);  
                  var dateparse=currentDate.fromNow().split(" ");
                  bool image=false;
                 if(met[index]['entities']['media']==null){                   
                   image=true;   
                 }else{
                   image=false;                  
                    url=met[index]['entities']['media'][0]['media_url'];
                 }               
                 return Card(                    
                   elevation: 0,
                   color: Colors.white,
                   child:Container(                     
                     padding: EdgeInsets.all(10),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                          CircleAvatar(
                            radius: 30,                          
                            backgroundImage:NetworkImage(met[index]['user']['profile_image_url_https'].replaceAll('_normal', '')),
                          ),
                          SizedBox(
                          width: 10,  
                          ),
                          Expanded(
                          child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                                  Row(
                                    children: <Widget>[
                           Text('${met[index]['user']['name']}',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
                           SizedBox(width: 5),
                           Text('@${met[index]['user']['screen_name']} · ${dateparse[0]+""+dateparse[1].substring(0,1)}',style: TextStyle(color:Colors.black45),)
                                    ],
                                  ),
                                 SizedBox(
                                  height: 5.0,
                                ),
                                Text(met[index]['text']),                           
                     
                                SizedBox(
                                  height: 10,
                                ),                            
                           ClipRRect(
                               borderRadius: BorderRadius.circular(5),
                               child: Container(
                               child: image?Text(''):Image.network('$url?format=jpg&name=small')
                           ),
                           ),
                           SizedBox(height: 20),
                           Row(
                               children: <Widget>[
                                 Icon((met[index]['favorite_count']>0?EvaIcons.heart:EvaIcons.heartOutline),size: 17,color: Colors.redAccent,),
                                  SizedBox(
                                   width: 5,
                                 ),
                                 Text(met[index]['favorite_count'].toString()),
                                 SizedBox(
                                   width: 20,
                                 ),
                                 Icon(EvaIcons.flip2,size: 17,color: Colors.green,),
                                  SizedBox(
                                   width: 5,
                                 ),
                                Text(met[index]['retweet_count'].toString()),
                               ],
                           )
                         ],
                       ),
                            ),
                       ]
                     )
                   )
                 );
               },
             );
             default:
             return Container();
            }
          },
        ),    
      );
  }
}