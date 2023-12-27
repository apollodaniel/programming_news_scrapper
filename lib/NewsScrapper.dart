import 'package:chaleno/chaleno.dart';
import 'package:news_scrapper/NewsBase.dart';

class NewsScrapper{

  static final Chaleno chaleno = Chaleno();

  static final TECH_MUNDO_URL = "https://www.tecmundo.com.br/programacao";
  static final SILICON_REPUBLIC_URL = "https://www.siliconrepublic.com/topics/coding/";
  static final OMG_LINUX_URL = "https://www.omglinux.com/";
  static final INFO_WORLD_URL = "https://www.infoworld.com/category/programming-languages/";
  static final INFO_WORLD_BASE_URL = "https://www.infoworld.com";


  static Future<List<NewsBase>> scrapTechmundoNews()async{
    Parser? parser = await chaleno.load(TECH_MUNDO_URL);
    List<NewsBase> techmundo_news = [];
    if(parser!=null){
      List<Result> result = parser.getElementsByClassName("tec--card tec--card--medium");

      List<String> names = result.map((e) => e.querySelector(".tec--card__title__link") == null ? "No name" : e.querySelector(".tec--card__title__link")!.text ?? "No name" ).toList();
      List<String> links = result.map((e) => e.querySelector(".tec--card__title__link") == null ? TECH_MUNDO_URL : e.querySelector(".tec--card__title__link")!.href ?? TECH_MUNDO_URL).toList();
      List<String> images = result.map((e) => e.querySelector(".tec--card__thumb__image") == null ? "No image" : e.querySelector(".tec--card__thumb__image")!.src ?? "No image").toList();

      for(int i = 0;i < result.length; i++){
        techmundo_news.add(
          NewsBase(title: names[i], image: images[i], url: links[i], website: TECH_MUNDO_URL)
        );
      }
    }
    return techmundo_news;
  }
  static Future<List<NewsBase>> scrapSiliconRepublic()async{
    Parser? parser = await chaleno.load(SILICON_REPUBLIC_URL);
    List<NewsBase> silicon_repuplic_news = [];
    if(parser!=null){
      List<Result> result = parser.getElementsByClassName("topicbox nocontent nopadding large-12 medium-12 small-12 columns end last");
      
      List<String> names = result.map((e) => e.querySelector(".large-5,.columns")!.querySelector("a") == null ? "No name" : e.querySelector(".large-5, .columns")!.querySelector("a")!.text ?? "No name").toList();
      List<String> links = result.map((e) => e.querySelector(".large-5,.columns")!.querySelector("a") == null ? SILICON_REPUBLIC_URL : e.querySelector(".large-5, .columns")!.querySelector("a")!.href ?? SILICON_REPUBLIC_URL).toList();
      List<String> images = result.map((e) => e.querySelector(".large-7,.columns, .nopadding")!.querySelector("picture")  == null ? "No image" : e.querySelector(".large-7, .columns, .nopadding")!.querySelector("picture")!.src ?? "No image").toList();

      for(int i = 0;i < result.length; i++){
        silicon_repuplic_news.add(
          NewsBase(title: names[i], image: images[i], url: links[i], website: SILICON_REPUBLIC_URL)
        );
      }
    }
    return silicon_repuplic_news;
  }
  static Future<List<NewsBase>> scrapOMGLinux()async{
    Parser? parser = await chaleno.load(OMG_LINUX_URL);
    List<NewsBase> omg_linux_news = [];
    if(parser!=null){
      List<Result> result = parser.querySelectorAll("article, .post");
      
      List<String> names = result.map((e) => e.querySelector(".entry-title")!.querySelector("a") == null ? "No name" : e.querySelector(".entry-title")!.querySelector("a")!.text ?? "No name").toList();
      List<String> links = result.map((e) => e.querySelector(".entry-title")!.querySelector("a") == null ? OMG_LINUX_URL : e.querySelector(".entry-title")!.querySelector("a")!.href ?? OMG_LINUX_URL).toList();
      List<String> images = result.map((e) => e.querySelector(".post-thumbnail")!.querySelector("img")  == null ? "No image" : e.querySelector(".post-thumbnail")!.querySelector("img")!.src ?? "No image").toList();

      for(int i = 0;i < result.length; i++){
        omg_linux_news.add(
          NewsBase(title: names[i], image: images[i], url: links[i], website: OMG_LINUX_URL)
        );
      }
    }
    return omg_linux_news;
  }

  static Future<List<NewsBase>> scrapInfoWorld()async{
    Parser? parser = await chaleno.load(INFO_WORLD_URL);
    List<NewsBase> info_world_news = [];
    if(parser!=null){
      List<Result> result = parser.getElementsByClassName("river-well article");
      // e.querySelector("a") == null ? "No name" : e.querySelector("a")!.text ?? "No name"
      List<String> names = result.map((e) => e.querySelector(".post-cont")!.querySelector("a") == null ? "No name" : e.querySelector(".post-cont")!.querySelector("a")!.text ?? "No name").toList();
      List<String> links = result.map((e) => e.querySelector(".post-cont")!.querySelector("a") == null ? INFO_WORLD_URL : "$INFO_WORLD_BASE_URL${e.querySelector(".post-cont")!.querySelector("a")!.href??""}").toList();
      List<String> images = result.map((e) => e.querySelector(".well-img")!.querySelector(".lazy")  == null ? "No image" : e.querySelector(".well-img")!.querySelector(".lazy")!.src ?? "No image").toList();

      for(int i = 0;i < result.length; i++){
        info_world_news.add(
          NewsBase(title: names[i], image: images[i], url: links[i], website: INFO_WORLD_URL)
        );
      }
    }
    return info_world_news;
  }

  static Future<List<NewsBase>> scrapAll()async{
    List<NewsBase> allNews = [];
    allNews.addAll(await scrapTechmundoNews());
    allNews.addAll(await scrapSiliconRepublic());
    allNews.addAll(await scrapOMGLinux());
    allNews.addAll(await scrapInfoWorld());
    return allNews;
  }
}
