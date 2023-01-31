import 'package:academy/core/service_locator.dart';
import 'package:academy/data/model/pokemon_model.dart';
import 'package:academy/domain/usescases/get_pokemon_list_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'lista_pokemon_event.dart';
import 'lista_pokemon_state.dart';

class ListaPokemonBloc extends Bloc<ListaPokemonEvent, ListaPokemonState> {
  ListaPokemonBloc() : super(ListaPokemonInitialState()) {

      PokemonList _pokemonList = []; // para mantener de forma temporal nuestra lista, así podremos añadir nuevos elementos, podriamos hacerlo con una BD interna
      PokemonList _pokemonListFavoritos = []; // para mantener de forma temporal nuestra lista, así podremos añadir nuevos elementos, podriamos hacerlo con una BD interna
      
      const int cuantosPokemon = 20; // cuantos pokemon pedir a la api


      on<ListaPokemonFetchData>(
        (event,emit) async{
          if(event.isRefresh){
            emit(ListaPokemonRefreshingState(pokemonList:_pokemonList)); // ------------------------------------------------- Empezamos a cargar
            _pokemonListFavoritos = [];
          }else{
            emit(ListaPokemonLoadingState()); // ------------------------------------------------- Empezamos a cargar
          }
          
            var result = await serviceLocator<GetPokemonListFromServer>().getProductsFromServer(cuantos: cuantosPokemon);
            result.fold(
              (error){
                emit(ListaPokemonErrorState(mensaje:error.mensaje));// --------------------------- return Error
              }, 
              (pokemonList) {
                _pokemonList = pokemonList;// ------------ guardamos localmente la lista 
                emit(ListaPokemonLoadedState(pokemonList: pokemonList, pokemonListFav: _pokemonListFavoritos));// --------------------------- return PokemonList
              }
            );
        }
      );
      on<ListaPokemonAddElement>(
        (event,emit) async{
          // aqui podriamos usar un caso de uso en el caso de que fuera 
          //pillarlo de la BD o de Remoto, en este caso no haria falta
          // HAY MUCHOS para ver que se añaden pedir menos pokemons
           _pokemonList.add(Pokemon.dummy());
          emit(ListaPokemonLoadedState(pokemonList: _pokemonList,pokemonListFav: _pokemonListFavoritos));// --------------------------- return PokemonList
        }
      );

      on<ListaPokemonAddFav>(
        (event, emit) {
          print("EVENTO -- añadir a fav: ${event.pokemon.name}");
          Pokemon pokemon = _pokemonList.firstWhere((element) => element.name == event.pokemon.name);
          if(!pokemon.fav){ // si no estaba en fav lo añadimos
            _pokemonListFavoritos.add(pokemon);
          }else{
            _pokemonListFavoritos.remove(pokemon);
          }
          pokemon.fav = !pokemon.fav; // le cambiamos el flag
          emit(ListaPokemonLoadedState(pokemonList: _pokemonList,pokemonListFav:_pokemonListFavoritos)); // ---------- return pokemon list
        },
      );

  }


}

