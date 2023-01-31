
import 'dart:async';

import 'package:academy/presentation/home/blocs/homepage/homepage_bloc.dart';
import 'package:academy/presentation/home/blocs/homepage/homepage_event.dart';
import 'package:academy/presentation/home/blocs/homepage/homepage_state.dart';
import 'package:academy/presentation/home/screens/pokemon_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utility.dart';
import '../../../data/model/pokemon_model.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);
  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {

  Completer<Null>? _completerFetchData;

  @override
  void initState() {
    super.initState();
    context.read<HomepageBloc>().add(HomePageFetchData(isRefresh: false),); // ---------------------- iniciar fetch de datos
  }

   Future<Null> _onRefresh() {
    _completerFetchData = Completer<Null>();
    context.read<HomepageBloc>().add(HomePageFetchData(isRefresh: true));
    // _completerFetchData.complete() se hace en el listener
    return _completerFetchData!.future;
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
          context.read<HomepageBloc>().add(HomePageAddElement());
        },
      ),
      body: BlocConsumer<HomepageBloc, HomepageState>(
        listener: (context, state) {
          if(state is HomePageErrorState){
            Utility.showSnackBar(context,state.mensaje);
          }else if(state is HomePageLoadedState){
            if(_completerFetchData !=null){
              _completerFetchData!.complete();
              _completerFetchData = null;
            }
          }
        },
        builder: (context, state) {
          if(state is HomePageLoadingState){
            return _buildLoadingState();
          }else if(state is HomePageLoadedState){
             return _buildLoadedState(state.pokemonList);
          }else if(state is HomePageRefreshingState){
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