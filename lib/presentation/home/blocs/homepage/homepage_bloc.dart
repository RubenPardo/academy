import 'package:academy/core/service_locator.dart';
import 'package:academy/data/model/pokemon_model.dart';
import 'package:academy/domain/usescases/get_pokemon_list_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homepage_event.dart';
import 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(HomePageInitialState()) {

      PokemonList _pokemonList = []; // para mantener de forma temporal nuestra lista, así podremos añadir nuevos elementos, podriamos hacerlo con una BD interna
      
      const int cuantosPokemon = 3;


      on<HomePageFetchData>(
        (event,emit) async{
          if(event.isRefresh){
            emit(HomePageRefreshingState(pokemonList:_pokemonList)); // ------------------------------------------------- Empezamos a cargar
          }else{
            emit(HomePageLoadingState()); // ------------------------------------------------- Empezamos a cargar
          }
          
            var result = await serviceLocator<GetPokemonListFromServer>().getProductsFromServer(cuantos: cuantosPokemon);
            result.fold(
              (error){
                emit(HomePageErrorState(mensaje:error.mensaje));// --------------------------- return Error
              }, 
              (pokemonList) {
                _pokemonList = pokemonList;// ------------ guardamos localmente la lista 
                emit(HomePageLoadedState(pokemonList: pokemonList));// --------------------------- return PokemonList
              }
            );
        }
      );


      on<HomePageAddElement>(
        (event,emit) async{
          // aqui podriamos usar un caso de uso en el caso de que fuera 
          //pillarlo de la BD o de Remoto, en este caso no haria falta
          // HAY MUCHOS para ver que se añaden pedir menos pokemons
           _pokemonList.add(Pokemon.dummy());
          emit(HomePageLoadedState(pokemonList: _pokemonList));// --------------------------- return PokemonList
        }
      );


  }
}