import 'dart:convert';

import 'package:rickandmorty_clean/domain/entities/character.dart';
import 'package:rickandmorty_clean/domain/entities/episode.dart';
import 'package:rickandmorty_clean/domain/entities/location.dart';
import 'package:rickandmorty_clean/secret/secret.dart';
import 'package:http/http.dart' as http;

class InfoApi {
  List<Character> personajes = [];
  List<Episode> episodios = [];
  List<Location> locaciones = [];

  Future<void> getPersonajes() async {
    String url = '$apiKeyCharacters';

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
  }

  Future<void> getEpisodios() async {
    String url = '$apiKeyEpisodes';

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
  }

  Future<void> getLocaciones() async {
    String url = '$apiKeyLocations';

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
  }
}
