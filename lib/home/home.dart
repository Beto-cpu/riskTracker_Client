import 'dart:async';
import 'dart:convert';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

var location = new Location();

Future<Home> fetchHome() async {
  Map<String, double> userLocation = await location.getLocation();
  return Home(userLocation: userLocation);
}

class Home {
  final Map<String, double> userLocation;

  Home({
    required this.userLocation,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Home> futureHome;

  @override
  void initState() {
    super.initState();
    futureHome = fetchHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<Home>(
          future: futureHome,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Parent(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar
                        Parent(
                          child: Txt(snapshot.data!.userLocation["latitude"]
                                  .toString() +
                              " , " +
                              snapshot.data!.userLocation["longitude"]
                                  .toString()),
                          style: ParentStyle()
                            ..alignment.topCenter()
                            ..padding(bottom: 20),
                        ),
                      ]),
                ),
                style: ParentStyle()
                  ..padding(vertical: 16, horizontal: 18)
                  ..background.color(const Color.fromRGBO(37, 150, 190, 1))
                  ..minHeight(6000),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
