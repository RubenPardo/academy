
import 'dart:async';

import 'package:academy/presentation/home/blocs/lista_pokemon/lista_pokemon_bloc.dart';
import 'package:academy/presentation/home/blocs/lista_pokemon/lista_pokemon_event.dart';
import 'package:academy/presentation/home/blocs/lista_pokemon/lista_pokemon_state.dart';
import 'package:academy/presentation/home/screens/pokemon_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utility.dart';
import '../../../data/model/pokemon_model.dart';

class ListAllPokemonScreen extends StatefulWidget {
  const ListAllPokemonScreen({Key? key}) : super(key: key);
  @override
  State<ListAllPokemonScreen> createState() => _ListAllPokemonScreenState();
}

class _ListAllPokemonScreenState extends State<ListAllPokemonScreen> {


  Completer<Null>? _completerFetchData; // completer para el refresh



   Future<Null> _onRefresh() {
    _completerFetchData = Completer<Null>();
    context.read<ListaPokemonBloc>().add(ListaPokemonFetchData(isRefresh: true));
    // _completerFetchData.complete() se hace en el listener
    return _completerFetchData!.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      
      body: BlocConsumer<ListaPokemonBloc, ListaPokemonState>(
        listener: (context, state) {
          if(state is ListaPokemonErrorState){
            Utility.showSnackBar(context,state.mensaje);
          }else if(state is ListaPokemonLoadedState){
            if(_completerFetchData !=null){
              _completerFetchData!.complete();
              _completerFetchData = null;
            }
          }
        },
        builder: (context, state) {
          if(state is ListaPokemonLoadingState){
            return _buildLoadingState();
          }else if(state is ListaPokemonLoadedState){
             return _buildLoadedState(state.pokemonList);
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
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          return PokemonItemWidget(pokemon: pokemonList[index]);
        },
      )
    );
  }
}