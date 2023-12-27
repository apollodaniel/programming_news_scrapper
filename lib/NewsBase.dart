import 'dart:convert';

class NewsBase{

  String title;
  String image;
  String url;
  String website;


  NewsBase({
    required this.title,
    required this.image,
    required this.url,
    required this.website
  });

  factory NewsBase.fromMap(Map map) => NewsBase(title: map["title"], image: map["image"], url: map["url"], website: map["website"]);

  factory NewsBase.fromJson(String json) => NewsBase.fromMap(jsonDecode(json));

  Map toMap() => {
    "title":title,
    "image":image,
    "url":url,
    "website":website
  };

  String toJson() => jsonEncode(toMap());

}

class Websites{

  static final uol = "UOL";
  static final g1 = "G1";
  static final cnn = "CNN";

}