import 'package:academy/core/service_locator.dart';
import 'package:academy/data/model/pokemon_info_model.dart';
import 'package:academy/domain/usescases/get_pokemon_list_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'lista_pokemon_event.dart';
import 'lista_pokemon_state.dart';

class ListaPokemonBloc extends Bloc<ListaPokemonEvent, ListaPokemonState> {
  ListaPokemonBloc() : super(ListaPokemonInitialState()) {

      PokemonList _pokemonListFiltrada = []; // para mantener de forma temporal nuestra lista, así podremos añadir nuevos elementos, podriamos hacerlo con una BD interna
      PokemonList _pokemonListFavoritos = []; // para mantener de forma temporal nuestra lista, así podremos añadir nuevos elementos, podriamos hacerlo con una BD interna
      PokemonList _pokemonListTodos = []; // tener todos todo el rato
      

       String tipo1 = "";
       String tipo2 = "";
       int cuantosPokemon = 10; // cuantos pokemon pedir a la api
      bool _isFetchinNewPokemon = false;

      on<ListaPokemonFetchData>(
        (event,emit) async{
          if(event.isRefresh){
            emit(ListaPokemonRefreshingState(pokemonList:_pokemonListFiltrada)); // ------------------------------------------------- Empezamos a cargar
            _pokemonListFavoritos = [];
          }else{
            emit(ListaPokemonLoadingState()); // ------------------------------------------------- Empezamos a cargar
          }
          
            var result = await serviceLocator<GetPokemonListFromServer>().getProductsFromServer(cuantos: cuantosPokemon, desde: 0);
            result.fold(
              (error){
                emit(ListaPokemonErrorState(mensaje:error.mensaje));// --------------------------- return Error
              }, 
              (pokemonList) {
                _pokemonListTodos = pokemonList;// ------------ guardamos localmente la lista 
                _pokemonListFiltrada = _filtrarPokemon(tipo1, tipo2,_pokemonListTodos);
                emit(ListaPokemonLoadedState(pokemonList: _pokemonListFiltrada, pokemonListFav: _pokemonListFavoritos));// --------------------------- return PokemonList
              }
            );
        }
      );
      
      on<ListaPokemonAddElement>(
        (event,emit) async{
          if(!_isFetchinNewPokemon){
            _isFetchinNewPokemon = true; // para evitar que se pidan repetidos
           var result = await serviceLocator<GetPokemonListFromServer>().getProductsFromServer(cuantos: 1, desde: cuantosPokemon);
            result.fold(
              (error){
                emit(ListaPokemonErrorState(mensaje:"No se pudo añadir un nuevo elemento"));// --------------------------- return Error
              }, 
              (pokemonList) {
                cuantosPokemon++; // la peticion ha ido perfecto sumamos uno a cuantos
                _isFetchinNewPokemon = false; // permitir volver a pulsar
                _pokemonListTodos.add(pokemonList.first);// ------------ lo guardamos localmente a la lista 
                _pokemonListFiltrada = _filtrarPokemon(tipo1, tipo2,_pokemonListTodos);
                emit(ListaPokemonLoadedState(pokemonList: _pokemonListFiltrada, pokemonListFav: _pokemonListFavoritos));// --------------------------- return PokemonList
              }
            );
          }
         
           
        }
      );

      on<ListaPokemonAddFav>(
        (event, emit) {
         
          Pokemon pokemon = _pokemonListTodos.firstWhere((element) => element.name == event.pokemon.name);
          if(!pokemon.fav){ // si no estaba en fav lo añadimos
            _pokemonListFavoritos.add(pokemon);
          }else{
            _pokemonListFavoritos.remove(pokemon);
          }
          pokemon.fav = !pokemon.fav; // le cambiamos el flag
          _pokemonListFiltrada = _filtrarPokemon(tipo1, tipo2,_pokemonListTodos);
          emit(ListaPokemonLoadedState(pokemonList: _pokemonListFiltrada,pokemonListFav:_pokemonListFavoritos)); // ---------- return pokemon list
        },
      );

      on<ListaPokemonFiltrar>(
        (event, emit) {
           tipo1 = event.tipo1;
           tipo2 = event.tipo2;
          // deshacemos filtros
          _pokemonListFiltrada = _filtrarPokemon(tipo1, tipo2,_pokemonListTodos);
          
         
          emit(ListaPokemonLoadedState(pokemonList: _pokemonListFiltrada,pokemonListFav:_pokemonListFavoritos)); // ---------- return pokemon list
        },
      );

  }

  List<Pokemon> _filtrarPokemon(String tipo1, String tipo2, List<Pokemon> listaAFiltrar){
    // si hay un filtro --
    List<Pokemon> listaFiltrada = listaAFiltrar;
    if(tipo1 == "" && tipo2 == ""){
      return listaFiltrada;
    }else{
      listaFiltrada = listaFiltrada.where((element){
        
        if(tipo1 != "" && tipo2 == ""){
          // filtrar tipo1 
            return element.firstPokemonType.toLowerCase() == tipo1;
          
          
        }else if(tipo1 == "" && tipo2 != ""){
          // filtrar tipo2 
            return element.secondPokemonType.toLowerCase() == tipo2;
          
        }else{
          // filtrar ambos
            return element.firstPokemonType.toLowerCase() == tipo1 && element.secondPokemonType.toLowerCase() == tipo2;
          
        }
      
      
      
      }).toList();
    }
     print("FILTRAR resultado $listaFiltrada");
    return listaFiltrada;
  }

}

