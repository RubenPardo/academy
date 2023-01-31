import 'package:academy/core/request.dart';
import 'package:academy/core/service_locator.dart';
import 'package:academy/data/model/pokemon_info_model.dart';

import '../../core/my_error.dart';
import 'package:either_dart/either.dart';

abstract class PokemonRemoteSource {
  Future<Either<MyError, PokemonList>> getPokemonFromServer(int cuantos,int desde);
  Future<Either<MyError, Pokemon>> getPokemonInfoFromServer(String url);
}


class PokemonRemoteSourceImpl implements PokemonRemoteSource{


  @override
  Future<Either<MyError, PokemonList>> getPokemonFromServer(int cuantos,int desde) async{
  
    try{
      final Request request = serviceLocator<Request>();

      final response = await request.get("pokemon?limit=$cuantos&offset=$desde");

      if (response.statusCode == 200) {
        PokemonList pokemonList = [];
        for(var pokemonData in response.data['results']){

          final response2 = await getPokemonInfoFromServer(pokemonData['url']);
          response2.fold((error) {}, 
            (pokemon) {
              pokemonList.add(pokemon);
            }
          );
            
        }
        return Right(pokemonList);
      }
      return Left(
        MyError(response.data['message']),
      );
    
    }catch(e){
      return Left(MyError("Error en getProductFromServer $e"));
    }

    
  }
  
  @override
  Future<Either<MyError, Pokemon>> getPokemonInfoFromServer(String url) async{
    try{
      final Request request = serviceLocator<Request>();

      final response = await request.get(url);

      if (response.statusCode == 200) {
        // TODO cambiar
        return Right( Pokemon.fromJson(response.data));
      }
      return Left(
        MyError(response.data['message']),
      );
    
    }catch(e){
      return Left(MyError("Error en getProductFromServer $e"));
    }
  }

}