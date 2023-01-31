
import 'package:academy/data/model/pokemon_info_model.dart';

abstract class ListaPokemonEvent{}

class ListaPokemonFetchData extends ListaPokemonEvent{
  bool isRefresh;
  ListaPokemonFetchData({required this.isRefresh});
}
class ListaPokemonAddElement extends ListaPokemonEvent{}
class ListaPokemonNotifyInfoElement extends ListaPokemonEvent{
  Pokemon pokemon;
  ListaPokemonNotifyInfoElement({required this.pokemon});
}

class ListaPokemonFiltrar extends ListaPokemonEvent{
  String tipo1;
  String tipo2;
  ListaPokemonFiltrar({required this.tipo1,required this.tipo2});
}
class ListaPokemonAddFav  extends ListaPokemonEvent{
  Pokemon pokemon;
  ListaPokemonAddFav({required this.pokemon});
}


