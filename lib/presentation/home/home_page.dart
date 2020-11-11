import 'package:flutter/material.dart';

import 'package:rickandmorty_clean/presentation/characters/characters_page.dart';
import 'package:rickandmorty_clean/presentation/episodes/episodes_page.dart';
import 'package:rickandmorty_clean/presentation/locations/locations_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 180.0),
                Image(image: AssetImage('assets/logo.png')),
                SizedBox(height: 70.0),
                _crearBoton(context, 'Personajes', CharacterPage()),
                SizedBox(height: 20.0),
                _crearBoton(context, 'Episodios', EpisodesPage()),
                SizedBox(height: 20.0),
                _crearBoton(context, 'Locaciones', LocationsPage()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearBoton(BuildContext context, String nombre, Widget ruta) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ruta)
        );
      },
      child: Container(
        width: 200.0,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black,
        ),
        child: Text(
          '$nombre',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}