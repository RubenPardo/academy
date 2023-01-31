import 'package:academy/domain/pokemon_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/service_locator.dart';
import 'homepage_event.dart';
import 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomePageInitialState()) {

      
      on<HomePageFetchData>(
        (event,emit) async{
            emit(HomePageLoadingState()); // ------------------------------------------------- Empezamos a cargar
            var result = await serviceLocator<PokemonRepository>().getPokemonFromServer();
            result.fold(
              (error){
                emit(HomePageErrorState(mensaje:error.mensaje));// --------------------------- return Error
              }, 
              (pokemonList) {
                emit(HomePageLoadedState(pokemonList: pokemonList));// --------------------------- return PokemonList
              }
            );
        }
      );


  }


}