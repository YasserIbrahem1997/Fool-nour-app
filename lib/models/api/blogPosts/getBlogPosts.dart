
class GetBlogPosts{
  late int id;
  late String date;
  late Title title;
  late String link;
  late Content content;


  GetBlogPosts(this.id, this.date, this.title, this.link, this.content);

  GetBlogPosts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    date = json['date'];
    title = Title.fromJson(json['title']);
    link = json['link'];
    content = Content.fromJson(json['content']);
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'date': date.toString(),
        'title': title.toJson(),
        'link': link.toString(),
        'content': content.toJson(),
      };
}

class Title{
  late String rendered;

  Title(this.rendered );
  Title.fromJson(Map<String, dynamic> json){
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() =>
      {
        'rendered': rendered,
      };
}

class Content{
  late String rendered;

  Content(this.rendered );
  Content.fromJson(Map<String, dynamic> json){
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() =>
      {
        'rendered': rendered,
      };
}
