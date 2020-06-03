import 'package:flutter/material.dart';
import 'package:my_app/views/home_view.dart';
import 'package:provider/provider.dart';
import 'datamodels/user_location.dart';
import 'services/location_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamProvider<UserLocation>(
        builder: (context) => LocationService().locationStream,
        child: MaterialApp(
          title: 'Speedometer',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: HomeView(),
          )
        ),
      ),
    );
  }
}
