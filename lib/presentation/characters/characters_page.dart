import 'package:flutter/material.dart';
import 'package:rickandmorty_clean/data/remote/rickandmorty_api.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key key}) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  var personajesList;

  void getPersonajesApi() async {
    InfoApi personajesApi = InfoApi();
    await personajesApi.getPersonajes();
    personajesList = personajesApi.personajes;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPersonajesApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personajes')
      ),
      body: (personajesList.length == null) 
      ? Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,))
      : ListView.separated(
        separatorBuilder: (_, int index) => Divider(height: 1, color: Colors.green), 
        itemCount: personajesList.length,
        itemBuilder: (_, index) {
          return ListTile(
            trailing: CircleAvatar(
              backgroundImage: NetworkImage('${personajesList[index].image}'),
            ),
            title: Text(
              'Nombre: ${personajesList[index].name}',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text('Especie: ${personajesList[index].species}'),
          );
        },
      ),
    );
  }
}