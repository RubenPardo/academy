import 'package:flutter/material.dart';

import '../../../data/model/pokemon_model.dart';

class PokemonItemWidget extends StatefulWidget  {

  final Pokemon pokemon;

  const PokemonItemWidget({Key? key, required this.pokemon}) : super(key: key);
  @override
  State<PokemonItemWidget> createState() => _PokemonItemWidgetState();
  
}

class _PokemonItemWidgetState extends State<PokemonItemWidget>{
  @override
  Widget build(BuildContext context) {

    return Padding(
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
    );

  }

  Widget _buildPokemonInfo(){
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
            children: [
              Text(
                widget.pokemon.name,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.pokemon.url,
                overflow: TextOverflow.clip,
                style:const  TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
      ],
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
}