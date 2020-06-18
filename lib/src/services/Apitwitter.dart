import 'dart:convert';

import 'package:twitter_api/twitter_api.dart';

class Apitwitter{

final _twitterOauth = new twitterApi(
  consumerKey: "consumerKey",
  consumerSecret: "consumerSecret",
  token: "consumerSecret",
  tokenSecret: "tokenSecret"
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