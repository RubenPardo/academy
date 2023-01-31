import 'package:academy/core/my_error.dart';
import 'package:academy/core/service_locator.dart';
import 'package:academy/data/datasource/pokemon_remote_source.dart';
import 'package:academy/data/model/pokemon_model.dart';
import 'package:either_dart/either.dart';

///
/// Esta capa nos serviria en el caso de añadir una base de datos internas
/// para asi desde aqui acceder al remote_source y al local_source
/// 
/// En el caso de tener dos data sources que usen diferentes modelos, podriamos
/// crear uno comun para las capas superiores a domain y hacer aqui un mapeo.
///
abstract class PokemonRepository{
  Future<Either<MyError,PokemonList>> getPokemonFromServer();
}

class PokemonRepositoryImpl implements PokemonRepository{
  @override
  Future<Either<MyError, PokemonList>> getPokemonFromServer() async{
    return await serviceLocator<PokemonRemoteSource>().getPokemonFromServer();
  }

}