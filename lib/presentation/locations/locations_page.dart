import 'package:flutter/material.dart';
import 'package:rickandmorty_clean/data/remote/rickandmorty_api.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  var locacionesList;

  void getLocacionesApi() async {
    InfoApi locacionesApi = InfoApi();
    await locacionesApi.getLocaciones();
    locacionesList = locacionesApi.locaciones;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLocacionesApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episodios')
      ),
      body: (locacionesList.length == null) 
      ? Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,))
      : ListView.separated(
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
    );
  }
}