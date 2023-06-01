
class GetDashboardCategories{
  late int id;
  late String name;
  late String description;
  late String slug;
  late int count;
  late String thumbnail;


  GetDashboardCategories(this.id, this.name, this.description, this.slug, this.count, this.thumbnail);

  GetDashboardCategories.fromJson(Map<String, dynamic> json){
    id = json.containsKey("id")?json['id']:json['term_id'];
    name = json['name'];
    description = json.containsKey("description")?json['description']:"";
    slug = json.containsKey("slug")?json['slug']:"";
    count = json.containsKey("count")?json['count']:0;
    thumbnail = json.containsKey("thumbnail") && json['thumbnail']!=null ?json['thumbnail']:"";
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'description': description,
        'slug': slug,
        'count': count,
        'thumbnail': thumbnail,
      };
}
