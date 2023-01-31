import 'package:academy/data/datasource/pokemon_remote_source.dart';
import 'package:academy/domain/repositories/pokemon_repository.dart';
import 'package:academy/domain/usescases/get_pokemon_list_use_case.dart';
import 'package:get_it/get_it.dart';


final serviceLocator = GetIt.instance;
Future<void> setUpServiceLocator() async {
  // homepage ---------------------------------------------------------------------------------
 
  //usecase -----------
  serviceLocator.registerFactory<GetPokemonListFromServer>(() => GetPokemonListFromServer());
  /*serviceLocator.registerFactory<ObtenerUsuarioCasoUso>(() => ObtenerUsuarioCasoUso());
  serviceLocator.registerFactory<ComprobarSesionCasoUso>(() => ComprobarSesionCasoUso());*/

  //datasource
  serviceLocator.registerFactory<PokemonRemoteSource>(() => PokemonRemoteSourceImpl());

  //repositories
  serviceLocator.registerFactory<PokemonRepository>(() => PokemonRepositoryImpl());

}