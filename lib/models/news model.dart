
class Article{
Source ?source;
String ?author,title,description,urlToImage,publishedAt;
Article({this.publishedAt,this.source,this.title,this.urlToImage,this.description,this.author});
static Article fromJson (Map<String,dynamic> map) => Article(
source: Source.fromJson(map['source']),
  description: map['description'],
  title: map['title'],
  author: map['author'],
  publishedAt: map['publishedAt'],
  urlToImage: map['urlToImage']
);
}

class Source {
String? name;
Source({this.name});
 static Source fromJson (Map<String,dynamic> map) => Source(
   name: map['name']
 );
}