import 'package:news_scrapper/NewsBase.dart';
import 'package:news_scrapper/NewsScrapper.dart';

void main(List arguments)async{

  List<NewsBase> news = await NewsScrapper.scrapAll();
  print(news.length); //news.forEach((element) => print("${element.toJson()}\n\n"),);
}