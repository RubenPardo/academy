import 'package:academy/data/model/pokemon_model.dart';

abstract class HomepageState{}

class HomePageInitialState extends HomepageState{}
class HomePageLoadingState extends HomepageState{}
class HomePageErrorState extends HomepageState{
  final String mensaje;
  HomePageErrorState({required this.mensaje});
}
class HomePageLoadedState extends HomepageState{
  final PokemonList pokemonList;
  HomePageLoadedState({required this.pokemonList});
}
