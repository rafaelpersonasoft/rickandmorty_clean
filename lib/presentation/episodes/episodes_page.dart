import 'package:flutter/material.dart';
import 'package:rickandmorty_clean/data/remote/rickandmorty_api.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({Key key}) : super(key: key);

  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  var episodiosList;
  bool _loader;

  void getEpisodiosApi() async {
    InfoApi episodiosApi = InfoApi();
    await episodiosApi.getEpisodios();
    episodiosList = episodiosApi.episodios;
    setState(() {
      _loader = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loader = true;
    getEpisodiosApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episodios')
      ),
      body: (_loader == true)
      ? Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,))
      : ListView.separated(
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
    );
  }
}