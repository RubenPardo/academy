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
}