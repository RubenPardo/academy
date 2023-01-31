import 'package:flutter/material.dart';
import 'app/app.dart';
import 'core/service_locator.dart';

void main() async{
  // inicializar inyector de dependencias ------------
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServiceLocator();
  // ------------------------------------------------
  runApp(App());
}
