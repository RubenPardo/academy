import 'package:academy/core/request.dart';
import 'package:academy/core/service_locator.dart';
import 'package:academy/data/model/pokemon_info_model.dart';

import '../../core/my_error.dart';
import 'package:either_dart/either.dart';

import '../model/pokemon_model.dart';

abstract class PokemonRemoteSource {
  Future<Either<MyError, PokemonList>> getPokemonFromServer();
  Future<Either<MyError, PokemonInfo>> getPokemonInfoFromServer(String url);
}


class PokemonRemoteSourceImpl implements PokemonRemoteSource{


  @override
  Future<Either<MyError, PokemonList>> getPokemonFromServer() async{
  
    try{
      final Request request = serviceLocator<Request>();

      final response = await request.get("pokemon?limit=100000&offset=0");

      if (response.statusCode == 200) {
        PokemonList pokemonList = [];
        for(var pokemonData in response.data['results']){
          pokemonList.add(Pokemon.fromJSON(pokemonData));
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
  Future<Either<MyError, PokemonInfo>> getPokemonInfoFromServer(String url) async{
    try{
      final Request request = serviceLocator<Request>();

      final response = await request.get(url);

      if (response.statusCode == 200) {
        // TODO cambiar
        return Right( PokemonInfo.fromJson(response.data));
      }
      return Left(
        MyError(response.data['message']),
      );
    
    }catch(e){
      return Left(MyError("Error en getProductFromServer $e"));
    }
  }

}