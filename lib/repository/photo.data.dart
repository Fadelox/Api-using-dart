import 'package:http/http.dart' as http;
import 'package:photos/model/photo.model.dart';
import 'dart:convert';

Future<List<Photo>> getPhotos(String motcle, int page) async {
  final Uri url = Uri.parse(
      'https://api.unsplash.com/search/photos/?client_id=gRH6vwcgieLi20oi0yg7yqRHQ4QRYRJOU3ac2o25oQQ&query=$motcle&page=$page');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var tab = json.decode(response.body)['results'];
    return [...tab.map((e) => Photo.fromJson(e))];
  } else {
    throw Exception('Erreur');
  }
}