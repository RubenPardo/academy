

import 'package:academy/data/model/pokemon_info_model.dart';

abstract class ListaPokemonState{}

class ListaPokemonInitialState extends ListaPokemonState{}
class ListaPokemonLoadingState extends ListaPokemonState{}
class ListaPokemonRefreshingState extends ListaPokemonState{
  final PokemonList pokemonList;
  ListaPokemonRefreshingState({required this.pokemonList});
}
class ListaPokemonErrorState extends ListaPokemonState{
  final String mensaje;
  ListaPokemonErrorState({required this.mensaje});
}
class ListaPokemonLoadedState extends ListaPokemonState{
  final PokemonList pokemonList;
  final PokemonList pokemonListFav;
  ListaPokemonLoadedState({required this.pokemonList, required  this.pokemonListFav});
}

class ListaPokemonFavAddedState extends ListaPokemonState{
  final PokemonList pokemonList;
  ListaPokemonFavAddedState({required this.pokemonList});
}

