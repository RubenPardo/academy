

import 'package:academy/core/utility.dart';
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
  String _selectedPokemonType1 = "";
  String _selectedPokemonType2 = "";
  
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
        actions: [
          IconButton(
            icon:const Icon(Icons.filter_alt_rounded),
            onPressed: (){
              _showBottomSheetMenu();
            })
        ],
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
  
  void _showBottomSheetMenu(){
    showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.only(top:64),
                height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      
                     Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const Text("Tipo1"),
                          const SizedBox(height: 8,),
                          DropdownButton<String>(
                            value: _selectedPokemonType1,
                            items: Utility.pokemonTypes().map((e) => DropdownMenuItem(value: e,child: Text(Utility.capitalize(e)),)).toList(), 
                            onChanged: (item){
                                setState(() {
                                  _selectedPokemonType1 = item!;
                                });
                                context.read<ListaPokemonBloc>().add(ListaPokemonFiltrar(tipo1: _selectedPokemonType1, tipo2: _selectedPokemonType2));
                                Navigator.pop(context);
                              }
                            ),
                          ],
                        )
                      ),
                      Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const Text("Tipo2"),
                          const SizedBox(height: 8,),
                          DropdownButton<String>(
                            value: _selectedPokemonType2,
                            items: Utility.pokemonTypes().map((e) => DropdownMenuItem(value: e,child: Text(Utility.capitalize(e)),)).toList(), 
                            onChanged: (item){
                                setState(() {
                                  _selectedPokemonType2 = item!;
                                });
                                context.read<ListaPokemonBloc>().add(ListaPokemonFiltrar(tipo1: _selectedPokemonType1, tipo2: _selectedPokemonType2));
                                Navigator.pop(context);
                              }
                            ),
                          ],
                        )
                      ),
                      
                    ],
                  ),
                
              );
          }, );
  }
  
 
}