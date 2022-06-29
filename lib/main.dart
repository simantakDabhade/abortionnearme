// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:abortionhelp/resultsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // the controller for the zipcode text field
  TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    searchCtrl.text = "79016";
    return Scaffold(
      body: Stack(
        children: [
          // this collumn on for the two containers that make up the background
          Column(
            children: [
              Expanded(
                child: Container(
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "AbortionNear.me",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color.fromRGBO(255, 51, 146, 1),
                          const Color.fromRGBO(255, 85, 51, 1),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.0),
                    Text("Enter Your Zip Code:",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 5.0),
                    TextField(
                      maxLength: 5,
                      textAlign: TextAlign.center,
                      controller: searchCtrl,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: 'Eg. 41223',
                        hintStyle: TextStyle(fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromRGBO(255, 43, 0, 1),
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromRGBO(255, 43, 0, 1),
                            style: BorderStyle.solid,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16),
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 18.0),
                    TextButton(
                      onPressed: () async {
                        var url = Uri.parse(
                            "https://maps.googleapis.com/maps/api/geocode/json?address=${searchCtrl.text}&key=AIzaSyAfoC6FiGKaGJ3ZppCdVvx1jeMqEIFL21c");
                        var response = await http.get(url);
                        Map dataMap = json.decode(response.body);
                        Map coordinates =
                            dataMap["results"][0]["geometry"]["location"];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => resultsPage(
                                    lat: coordinates["lat"],
                                    lng: coordinates["lng"],
                                    zipcode: searchCtrl.text,
                                  )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(255, 90, 56, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Color.fromRGBO(255, 90, 56, 1)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
