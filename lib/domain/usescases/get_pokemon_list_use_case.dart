import 'package:academy/core/my_error.dart';
import 'package:academy/data/model/pokemon_info_model.dart';
import 'package:either_dart/either.dart';

import '../../core/service_locator.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonListFromServer {
  Future<Either<MyError, PokemonList>> getProductsFromServer({required int cuantos, required int desde}) {
    return serviceLocator<PokemonRepository>().getPokemonFromServer(cuantos,desde);
  }
}