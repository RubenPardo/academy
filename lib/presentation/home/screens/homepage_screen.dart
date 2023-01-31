

import 'package:academy/presentation/home/blocs/lista_pokemon/lista_pokemon_bloc.dart';
import 'package:academy/presentation/home/blocs/lista_pokemon/lista_pokemon_event.dart';
import 'package:academy/presentation/home/screens/list_all_pokemon_screen.dart';
import 'package:academy/presentation/home/screens/list_fav_pokemon_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);
  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {

  int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget>[
    ListAllPokemonScreen(),
    ListFavPokemonScreen(),
  ];

  

  @override
  void initState() {
    super.initState();
    context.read<ListaPokemonBloc>().add(ListaPokemonFetchData(isRefresh: false),); // ---------------------- iniciar fetch de datos
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(
          title: const Text('Pokedex'),
        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          context.read<ListaPokemonBloc>().add(ListaPokemonAddElement());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: Center(  
        child: _widgetOptions.elementAt(_selectedIndex),  
      )
    );
  }
  
  
}