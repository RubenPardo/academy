

import 'package:academy/core/service_locator.dart';
import 'package:academy/domain/usescases/get_infor_pokemon_use_case.dart';
import 'package:academy/presentation/home/blocs/pokemon_item/pokemon_item_event.dart';
import 'package:academy/presentation/home/blocs/pokemon_item/pokemon_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PokemonItemBloc extends Bloc<PokemonItemEvent, PokemonItemState> {
  PokemonItemBloc() : super(PokemonItemInitialState()) {


    on<PokemonItemFetchData>((event, emit) async{
      emit(PokemonItemLoadingState());
      //await Future<>
      var result = await serviceLocator<GetPokemonInfoFromServer>().getProductsFromServer(event.url);
      result.fold(
        (error){
          emit(PokemonItemErrorState(mensaje: "Error al obtener los datos del pokemon ${error.mensaje}"));
        },
        (pokemonInfo){
          emit(PokemonItemLoadedState(pokemonInfo: pokemonInfo));
        }       
      );
      
    },);
   
  }
}