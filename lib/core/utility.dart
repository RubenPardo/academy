import 'package:flutter/material.dart';

class Utility{
  static void showSnackBar(context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      message,
                    ),
                  ),
                );
  }


  static TextStyle cardTitleStyle =TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Open Sans',
                  fontSize: 32);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static String capitalize(String string) {
    if(string.isNotEmpty){
      
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
    }else{
      return "";
    }
  }

  // quedan mas pero para probar sobra
  static List<String> pokemonTypes() {
    return [
      "",
      "poison",
      "bug",
      "flying",
      "fire",
      "water",
      "grass",
      "rock",
      "dark",
      "dragon",
      "fairy"
    ];
  }

}