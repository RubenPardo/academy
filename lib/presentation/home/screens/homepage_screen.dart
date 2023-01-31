import 'package:academy/presentation/home/blocs/homepage_event.dart';
import 'package:academy/presentation/home/screens/pokemon_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utility.dart';
import '../../../data/model/pokemon_model.dart';
import '../blocs/homepage_bloc.dart';
import '../blocs/homepage_state.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);
  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomepageBloc>().add(HomePageFetchData(),); // ---------------------- iniciar fetch de datos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(
          title: const Text('Pokedex'),
        ),
      body: BlocConsumer<HomepageBloc, HomepageState>(
        listener: (context, state) {
          if(state is HomePageErrorState){
            Utility.showSnackBar(context,state.mensaje);
          }
        },
        builder: (context, state) {
          if(state is HomePageLoadingState){
            return _buildLoadingState();
          }else if(state is HomePageLoadedState){
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