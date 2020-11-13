import 'package:flutter/material.dart';
import 'package:rickandmorty_clean/data/remote/rickandmorty_api.dart';
import 'package:rickandmorty_clean/secret/secret.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  var locacionesList;
  var infoGeneral;
  bool _loader;

  void getLocacionesApi(String ruta) async {
    InfoApi locacionesApi = InfoApi();
    await locacionesApi.getLocaciones(ruta);
    locacionesList = locacionesApi.locaciones;
    infoGeneral = locacionesApi.infoLocaciones;
    setState(() {
      _loader = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loader = true;
    getLocacionesApi('$apiKeyLocations');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locaciones')
      ),
      body: (_loader == true) 
      ? Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,))
      : Stack(
        children: [
          ListView.separated(
            separatorBuilder: (_, int index) => Divider(height: 1, color: Colors.green), 
            itemCount: locacionesList.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  '${locacionesList[index].name}',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                subtitle: Text('Episodio: ${locacionesList[index].type}'),
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
          getLocacionesApi(ruta);
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