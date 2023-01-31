import 'package:academy/core/utility.dart';
import 'package:academy/data/model/pokemon_info_model.dart';
import 'package:academy/presentation/home/blocs/pokemon_item/pokemon_item_bloc.dart';
import 'package:academy/presentation/home/blocs/pokemon_item/pokemon_item_event.dart';
import 'package:academy/presentation/home/blocs/pokemon_item/pokemon_item_state.dart';
import 'package:academy/shared/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/pokemon_model.dart';

class PokemonItemWidget extends StatefulWidget  {

  final Pokemon pokemon;

  const PokemonItemWidget({Key? key, required this.pokemon}) : super(key: key);
  @override
  State<PokemonItemWidget> createState() => _PokemonItemWidgetState();
  
}

class _PokemonItemWidgetState extends State<PokemonItemWidget>{

  PokemonItemBloc _pokemonItemBloc = PokemonItemBloc();

  @override
  void initState() {
    _pokemonItemBloc.add(PokemonItemFetchData(url:widget.pokemon.url));
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  children: <Widget>[
                      _buildPokemonInfo(),
                      _buildFavoriteButton(),
                  ],
                ),
              )
            ]),
        )
      ),
    );

  }

  Widget _buildPokemonInfo(){
    return BlocConsumer(
      bloc: _pokemonItemBloc,
      builder: (context, state) {
        if(state is PokemonItemLoadingState){
          return _buildPokemonInfoLoading();
        }else if(state is PokemonItemLoadedState){
          return _buildPokemonInfoLoaded(state.pokemonInfo);
        }
        return Center();

      }, 
      listener: (context, state) {
        if(state is PokemonItemErrorState){
            Utility.showSnackBar(context,state.mensaje);
          }
      },
    );
  }

  // TODO cambiar a boton
  Widget _buildFavoriteButton() {
  return const Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Icon(
          Icons.favorite_border,
          color: Colors.redAccent,
          size: 40,
        ),
      )
    );
  }
  
  Widget _buildPokemonInfoLoading() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // IMAGEN ------------------------------------------------
        Container(
          constraints: const BoxConstraints(maxWidth: 150),
          child: Image.asset('assets/images/no_image.png',),
        ),
        // Info ------------------------------------------------
        Expanded(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(padding: EdgeInsets.only(right: 24), child: ShimmerLoading(height: 24, borderRadius: 16),),
              SizedBox(height: 10),
              Padding(padding: EdgeInsets.only(right: 24), child: ShimmerLoading(height: 48, borderRadius: 8),)
              
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPokemonInfoLoaded(PokemonInfo pokemonInfo) {
     return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // IMAGEN ------------------------------------------------
        Container(
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(maxWidth: 150),
          child: Image.network(pokemonInfo.sprite,
          loadingBuilder: (context, child, loadingProgress) {
            if(loadingProgress == null) return child;
            return Image.asset("assets/images/no_image.png");
          },),
        ),
        // Info ------------------------------------------------
        Expanded(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pokemonInfo.name, style: Utility.cardTitleStyle,),
              const SizedBox(height: 10),
              Row(children: [
                Text(pokemonInfo.firstPokemonType),
                const SizedBox(width: 10),
                Text(pokemonInfo.secondPokemonType),
              ],)
              
            ],
          ),
        )
      ],
    );
  }
}