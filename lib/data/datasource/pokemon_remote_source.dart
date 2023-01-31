import '../../core/my_error.dart';
import 'package:either_dart/either.dart';

import '../model/pokemon_model.dart';

abstract class PokemonRemoteSource {
  Future<Either<MyError, PokemonList>> getPokemonFromServer();
}


class PokemonRemoteSourceImpl implements PokemonRemoteSource{


  @override
  Future<Either<MyError, PokemonList>> getPokemonFromServer() async{
    // TODO: implement getProductFromServer
    try{
      PokemonList pokemonList = [];

      for(int i = 0;i<10;i++){
        pokemonList.add(Pokemon.dummy());
      }

      await Future.delayed(const Duration(seconds: 1));

      return Right(pokemonList);
    }catch(e){

      return const Left(MyError("Error en getProductFromServer"));
    }

    
  }

}