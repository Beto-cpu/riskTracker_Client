import 'dart:async';
import 'dart:convert';

import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String id = "61588dbd17cea6087fefe101";

Future<User> fetchUser() async {
  final response = await http
      .get(Uri.parse('https://risk-tracker.herokuapp.com/users/' + id));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load User');
  }
}

class User {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String phone;

  User({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
    );
  }
}

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Parent(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar
                        Parent(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.asset('assets/images/corgi.jpg'),
                          ),
                          style: ParentStyle()
                            ..alignment.topCenter()
                            ..padding(bottom: 20),
                        ),

                        // Name
                        Row(
                          children: [
                            Parent(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Txt("Name",
                                        style: TxtStyle()
                                          ..fontSize(24)
                                          ..bold()),
                                    Txt(snapshot.data!.name,
                                        style: TxtStyle()..fontSize(24)),
                                  ]),
                              style: ParentStyle()..alignment.bottomLeft(),
                            ),
                            SizedBox(width: 50),
                            Parent(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Txt("Last Name",
                                        style: TxtStyle()
                                          ..fontSize(24)
                                          ..bold()),
                                    Txt(snapshot.data!.lastName,
                                        style: TxtStyle()..fontSize(24)),
                                  ]),
                              style: ParentStyle()..alignment.topLeft(),
                            ),
                          ],
                        ),

                        // Email
                        Parent(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Txt("Email",
                                    style: TxtStyle()
                                      ..fontSize(24)
                                      ..bold()),
                                Txt(snapshot.data!.email,
                                    style: TxtStyle()..fontSize(24)),
                              ]),
                          style: ParentStyle()
                            ..alignment.bottomLeft()
                            ..padding(top: 17),
                        ),

                        // Phone
                        Parent(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Txt("Phone",
                                    style: TxtStyle()
                                      ..fontSize(24)
                                      ..bold()),
                                Txt(snapshot.data!.phone,
                                    style: TxtStyle()..fontSize(24)),
                              ]),
                          style: ParentStyle()
                            ..alignment.bottomLeft()
                            ..padding(top: 17),
                        ),

                        // Password
                        Parent(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Txt("Password",
                                    style: TxtStyle()
                                      ..fontSize(24)
                                      ..bold()),
                                Txt("*********",
                                    style: TxtStyle()..fontSize(24)),
                              ]),
                          style: ParentStyle()
                            ..alignment.bottomLeft()
                            ..padding(vertical: 17),
                        ),

                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 40),
                                  primary: Colors.orange,
                                  textStyle: const TextStyle(fontSize: 20)),
                              onPressed: () {},
                              child: const Text('Edit'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 40),
                                  primary: Colors.red,
                                  textStyle: const TextStyle(fontSize: 20)),
                              onPressed: () {},
                              child: const Text('Log Out'),
                            ),
                          ],
                        )
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
