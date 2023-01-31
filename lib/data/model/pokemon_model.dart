/// 
/// Primero se obtiene un listado de nombre,url de los pokemon
/// Esto objeto lo usaremos para pasarselo al item de la vista y él 
/// ya pedira toda la información en su respectivo bloc
/// 


typedef PokemonList = List<Pokemon>;

class Pokemon{

 
   final String name;
   final String url;

  /*Pokemon(Map<String, Object?> json){
    print("Pokemon.fromJSON");
    print(json);
  }*/

  Pokemon(this.name, this.url);

  //factory Pokemon.fromJson(Map<String, Object?> json) => Pokemon(json);
  factory Pokemon.dummy() => Pokemon("nombre-prueba","https://pokeapi.co/api/v2/pokemon/1/");
  
}
