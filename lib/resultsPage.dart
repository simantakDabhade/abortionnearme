// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:convert';

import 'package:abortionhelp/calculator.dart';
import 'package:flutter/material.dart';

class resultsPage extends StatefulWidget {
  late double lat;
  late double lng;
  late String zipcode;
  resultsPage({required this.lat, required this.lng, required this.zipcode});

  @override
  State<resultsPage> createState() => _resultsPageState();
}

class _resultsPageState extends State<resultsPage> {
  @override
  Widget build(BuildContext context) {
    List? clinicList = calculator().getClinics(widget.lat, widget.lng);
    print(clinicList);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 245, 243, 1.0),
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.pinkAccent,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text(
          "AbortionNear.me",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Abortion Clinics near ${widget.zipcode}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25.0),
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                clinicList![index][1]["name"],
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                clinicList![index][1]["address"],
                                style: TextStyle(fontSize: 18.0),
                              ),
                              SizedBox(height: 10.0),
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "website",
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(clinicList![index][1]["phoneNum"]),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: clinicList?.length ?? 0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
