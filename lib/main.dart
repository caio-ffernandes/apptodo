import 'package:flutter/material.dart';
import 'screens/earth_screen.dart';
import 'screens/water_screen.dart';
import 'screens/fire_screen.dart';
import 'screens/air_screen.dart';
import 'widgets/element_button.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path); 
  runApp(FourElementsTodoApp());
}

class FourElementsTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fifith Element To-Do',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Four Elements To-Do'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElementButton(
              title: 'Terra',
              color: Colors.green,
              screen: EarthScreen(),
            ),
            ElementButton(
              title: 'Água',
              color: Colors.blue,
              screen: WaterScreen(),
            ),
            ElementButton(
              title: 'Fogo',
              color: Colors.red,
              screen: FireScreen(),
            ),
            ElementButton(
              title: 'Ar',
              color: Colors.grey,
              screen: AirScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
