import 'package:flutter/material.dart';
import 'package:rickandmorty_clean/data/remote/rickandmorty_api.dart';
import 'package:rickandmorty_clean/secret/secret.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({Key key}) : super(key: key);

  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  var episodiosList;
  var infoGeneral;
  bool _loader;

  void getEpisodiosApi(String ruta) async {
    InfoApi episodiosApi = InfoApi();
    await episodiosApi.getEpisodios(ruta);
    episodiosList = episodiosApi.episodios;
    infoGeneral = episodiosApi.infoEpisodios;
    setState(() {
      _loader = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loader = true;
    getEpisodiosApi('$apiKeyEpisodes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episodios')
      ),
      body: (_loader == true)
      ? Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,))
      : Stack(
        children: [
          ListView.separated(
          separatorBuilder: (_, int index) => Divider(height: 1, color: Colors.green), 
            itemCount: episodiosList.length,
            itemBuilder: (_, index) {
              return ListTile(
                trailing: Text('${episodiosList[index].airDate}'),
                title: Text(
                  '${episodiosList[index].name}',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text('Episodio: ${episodiosList[index].episode}'),
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
          getEpisodiosApi(ruta);
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