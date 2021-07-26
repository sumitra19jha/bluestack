import 'dart:convert';

import 'package:bluestack/Models/gamealbum.dart';
import 'package:bluestack/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataList extends ChangeNotifier {
  Future<List<Album>> fetchAlbum() async {
    final response = await http.get(Uri.parse(
        'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all'));

    if (response.statusCode == 200) {
      List datas = jsonDecode(response.body)["data"]["tournaments"];
      List<Album> albums = [];

      datas.forEach((element) {
        albums.add(Album.fromJson(element));
      });

      print(albums);

      return albums;
    } else {
      throw Exception('Failed to load game album');
    }
  }

  Future<User> fetchUser() async {
    final response = await http
        .get(Uri.parse('https://bluestackuser.free.beeceptor.com/my/api/user'));
    print(response.body);

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Users');
    }
  }
}
