

import 'package:academy/data/model/pokemon_info_model.dart';
import 'package:academy/presentation/home/blocs/lista_pokemon/lista_pokemon_bloc.dart';
import 'package:academy/presentation/home/blocs/lista_pokemon/lista_pokemon_state.dart';
import 'package:academy/presentation/home/screens/pokemon_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utility.dart';

class ListFavPokemonScreen extends StatefulWidget {
  const ListFavPokemonScreen({Key? key}) : super(key: key);
  @override
  State<ListFavPokemonScreen> createState() => _ListFavPokemonScreenState();
}

class _ListFavPokemonScreenState extends State<ListFavPokemonScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      
      body: BlocConsumer<ListaPokemonBloc, ListaPokemonState>(
        listener: (context, state) {
          if(state is ListaPokemonErrorState){
            Utility.showSnackBar(context,state.mensaje);
          }
        
        },
        builder: (context, state) {
          if(state is ListaPokemonLoadingState){
            return _buildLoadingState();
          }else if(state is ListaPokemonLoadedState){
             return _buildLoadedState(state.pokemonListFav);
          }else if(state is ListaPokemonRefreshingState){
             return _buildLoadedState(state.pokemonList);
          }else if(state is ListaPokemonFavAddedState){
             return _buildLoadedState(state.pokemonList);
          }else{
            return const Center(); // Cuando haya error llegara aqui?
          }
        },
      )
    );
  }
  
  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }
  
  /// devuelve un listview builder con los items de la lista de pokemon
  Widget _buildLoadedState(PokemonList pokemonList) {
    return ListView.builder(
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          return PokemonItemWidget(pokemon: pokemonList[index]);
        },
    );
  }
}