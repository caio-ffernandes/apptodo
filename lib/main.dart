import 'package:flutter/material.dart';
import 'screens/earth_screen.dart';
import 'screens/water_screen.dart';
import 'screens/fire_screen.dart';
import 'screens/air_screen.dart';
import 'widgets/element_button.dart';

void main() {
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
