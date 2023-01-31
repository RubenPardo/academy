import 'package:academy/data/model/pokemon_model.dart';
import 'package:academy/presentation/home/blocs/pokemon_item/pokemon_item_bloc.dart';

abstract class ListaPokemonEvent{}

class ListaPokemonFetchData extends ListaPokemonEvent{
  bool isRefresh;
  ListaPokemonFetchData({required this.isRefresh});
}
class ListaPokemonAddElement extends ListaPokemonEvent{}
class ListaPokemonAddFav  extends ListaPokemonEvent{
  Pokemon pokemon;
  ListaPokemonAddFav({required this.pokemon});
}


