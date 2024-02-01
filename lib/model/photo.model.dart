
class Photo{
  String name;
  String url;
  Photo({required this.name,required this.url});
  factory Photo.fromJson(json){
    return Photo(name:json['user']['name'], url: json['urls']['thumb']);
  }
}