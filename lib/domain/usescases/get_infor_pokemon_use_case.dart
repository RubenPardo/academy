

import 'package:academy/core/my_error.dart';
import 'package:academy/core/service_locator.dart';
import 'package:academy/data/model/pokemon_info_model.dart';
import 'package:either_dart/either.dart';
import '../repositories/pokemon_repository.dart';
class GetPokemonInfoFromServer {
  Future<Either<MyError, PokemonInfo>> getProductsFromServer(String url) {
    return serviceLocator<PokemonRepository>().getPokemonInfoFromServer(url);
  }
}