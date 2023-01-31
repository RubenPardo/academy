import 'package:academy/core/utility.dart';

typedef PokemonList = List<Pokemon>;

class Pokemon {

  bool fav = false;
  final String name;
  final int id;
  final String firstPokemonType;
  final String secondPokemonType;
  final String sprite;

  /*Pokemon(Map<String, Object?> json){
    print("Pokemon.fromJSON");
    print(json);
  }*/

  Pokemon(this.id, this.name, this.firstPokemonType, this.secondPokemonType, this.sprite);

  
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    try{
      return Pokemon(
        json['id'] as int,
        Utility.capitalize(json['name']),
        Utility.capitalize(json['types'][0]['type']['name']),
        (json['types'] as List).length>1 ? Utility.capitalize(json['types'][1]['type']['name']) : "",
        json['sprites']['other']['official-artwork']['front_default'] ?? "");
    }catch(e){
      throw Exception(e);
    }
  }

  factory Pokemon.dummy(){
    return Pokemon(
      1,
      "este nombre prueba",
      "water",
      "fire",
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png");
  }
  
}