
import 'package:academy/presentation/home/blocs/homepage/homepage_bloc.dart';
import 'package:academy/presentation/home/blocs/pokemon_item/pokemon_item_bloc.dart';
import 'package:academy/presentation/home/screens/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomepageBloc(),
        ),
       /* BlocProvider( No hay que ponerlo aqui sino en cada item para que sea independiente
          create: (_) => PokemonItemBloc(),
        ),*/
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        ),
        home: const HomepageScreen(),
      ),
    );
  }
}