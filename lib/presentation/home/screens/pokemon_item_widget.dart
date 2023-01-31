import 'package:academy/core/utility.dart';
import 'package:academy/data/model/pokemon_info_model.dart';
import 'package:academy/presentation/home/blocs/lista_pokemon/lista_pokemon_bloc.dart';
import 'package:academy/presentation/home/blocs/lista_pokemon/lista_pokemon_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PokemonItemWidget extends StatefulWidget  {

  final Pokemon pokemon;

  const PokemonItemWidget({Key? key, required this.pokemon}) : super(key: key);
  @override
  State<PokemonItemWidget> createState() => _PokemonItemWidgetState();
  
}

class _PokemonItemWidgetState extends State<PokemonItemWidget>{



  @override
  void initState() {
    super.initState();
   
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
                      _buildPokemon(widget.pokemon),
                      _buildFavoriteButton(),
                  ],
                ),
              )
            ]),
        )
      ),
    );

  }



  Widget _buildFavoriteButton() {
  return  Align(
    alignment: Alignment.topRight,
    child: GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
            widget.pokemon.fav ? Icons.favorite : Icons.favorite_border,
            color:  Colors.redAccent,
            size: 40,
          ),
        ),
        onTap: () {
          context.read<ListaPokemonBloc>().add(ListaPokemonAddFav(pokemon: widget.pokemon));
        },
      )
    );
  }
  

  Widget _buildPokemon(Pokemon pokemonInfo) {
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