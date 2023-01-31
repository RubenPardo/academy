import 'package:academy/data/model/pokemon_info_model.dart';

abstract class PokemonItemState{}

class PokemonItemInitialState extends PokemonItemState{}
class PokemonItemLoadingState extends PokemonItemState{}
class PokemonItemErrorState extends PokemonItemState{
  final String mensaje;
  PokemonItemErrorState({required this.mensaje});
}
class PokemonItemLoadedState extends PokemonItemState{
  final PokemonInfo pokemonInfo;
  PokemonItemLoadedState({required this.pokemonInfo});
}

