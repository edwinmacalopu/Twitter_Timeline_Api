import 'dart:convert';

import 'package:twitter_api/twitter_api.dart';

class Apitwitter{

final _twitterOauth = new twitterApi(
  consumerKey: "IXkOp3SDBJT2wkF8IP7WcXWCw",
  consumerSecret: "Y785F9QTxGYLBvuESARExxxi8DOduKR0iw3TaIhVrBaCSeBLBS",
  token: "395651673-6ULAkTt1Jo8dBTRKCF1UNckAYd5iIToVX3InwRRJ",
  tokenSecret: "cLBmiMIF1Pox3H9YGmUex9f0n1776uRZklLhqMbpwYlGg"
);

Future<List> getTwitterTimeline()async{
Future twitterRequest = _twitterOauth.getTwitterRequest(
  "GET", 
  "statuses/user_timeline.json", 
  options: {
    //"user_id": "19025957",
    "screen_name": "edwindz2",
    "count": "10",
    //"trim_user": "true",
   // "tweet_mode": "extended",
  },
);
var res = await twitterRequest;
var tweets = json.decode(res.body);
  return tweets;
}

}