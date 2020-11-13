import 'package:flutter/material.dart';
import 'package:rickandmorty_clean/data/remote/rickandmorty_api.dart';
import 'package:rickandmorty_clean/secret/secret.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key key}) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  var personajesList;
  var infoGeneral;
  bool _loader;

  void getPersonajesApi(String ruta) async {
    InfoApi personajesApi = InfoApi();
    await personajesApi.getPersonajes(ruta);
    personajesList = personajesApi.personajes;
    infoGeneral = personajesApi.infoPersonajes;
    setState(() {
      _loader = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loader = true;
    getPersonajesApi('$apiKeyCharacters');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personajes')
      ),
      body: (_loader == true) 
      ? Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,))
      : Stack(
          children:[ 
            ListView.separated(
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
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 10.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _botonNavegacion(Icon(Icons.arrow_back, color: Colors.white), infoGeneral['prev']),
                SizedBox(width: 20.0,),
                _botonNavegacion(Icon(Icons.arrow_forward, color: Colors.white), infoGeneral['next']),
              ],
            ),
          ),  
        ],
      ),
    );
  }

  Widget _botonNavegacion(Widget icono, String ruta) {
    return InkWell(
      onTap: (){
        if(ruta != null){
          getPersonajesApi(ruta);
        }
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.blue,
        ),
        child: icono
      ),
    );
  }
}