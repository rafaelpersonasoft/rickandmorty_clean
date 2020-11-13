import 'dart:convert';

import 'package:rickandmorty_clean/domain/entities/character.dart';
import 'package:rickandmorty_clean/domain/entities/episode.dart';
import 'package:rickandmorty_clean/domain/entities/location.dart';
import 'package:rickandmorty_clean/secret/secret.dart';
import 'package:http/http.dart' as http;

class InfoApi {
  List<Character> personajes = [];
  Map<String, String> infoPersonajes = {};
  List<Episode> episodios = [];
  Map<String, String> infoEpisodios = {};
  List<Location> locaciones = [];
  Map<String, String> infoLocaciones = {};

  Future<void> getPersonajes(String ruta) async {
    String url = ruta;

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    jsonData["results"].forEach((element) {
      if (element['name'] != null && 
          element['image'] != null && 
          element['species'] != null) {
        Character info = Character(
          name: element['name'],
          image: element['image'],
          species: element['species'],
        );
        personajes.add(info);
      }
    });

    if(jsonData["info"] != null) {
      var base = jsonData["info"];
      infoPersonajes['next'] = base['next'];
      infoPersonajes['prev'] = base['prev'];
    }
  }

  Future<void> getEpisodios(String ruta) async {
    String url = ruta;

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    jsonData["results"].forEach((element) {
      if (element['name'] != null && 
          element['air_date'] != null && 
          element['episode'] != null) {
        Episode info = Episode(
          name: element['name'],
          airDate: element['air_date'],
          episode: element['episode'],
        );
        episodios.add(info);
      }
    });

    if(jsonData["info"] != null) {
      var base = jsonData["info"];
      infoEpisodios['next'] = base['next'];
      infoEpisodios['prev'] = base['prev'];
    }
  }

  Future<void> getLocaciones(String ruta) async {
    String url = ruta;

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    jsonData["results"].forEach((element) {
      if (element['name'] != null && 
          element['type'] != null) {
        Location info = Location(
          name: element['name'],
          type: element['type']
        );
        locaciones.add(info);
      }
    });

    if(jsonData["info"] != null) {
      var base = jsonData["info"];
      infoLocaciones['next'] = base['next'];
      infoLocaciones['prev'] = base['prev'];
    }
  }
}
