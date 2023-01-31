typedef PokemonInfoList = List<PokemonInfo>;

class PokemonInfo{

   final int id;
   final String name;
   final String order;
   final String firstPokemonType;
   final String secondPokemonType;
   final String sprite;

  /*Pokemon(Map<String, Object?> json){
    print("Pokemon.fromJSON");
    print(json);
  }*/

  PokemonInfo(this.id, this.name, this.order, this.firstPokemonType, this.secondPokemonType, this.sprite);

  //factory Pokemon.fromJson(Map<String, Object?> json) => Pokemon(json);
  factory PokemonInfo.dummy() => PokemonInfo(1,"nombre-prueba","001","water","fire","https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png");
  
}