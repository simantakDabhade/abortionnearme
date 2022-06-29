import 'dart:math';

import 'package:flutter/material.dart';

// finds the nearest clinics
class calculator {
  List<Map> Clinics = [
    {
      "lat": 38.09464,
      "lng": -122.25386,
      "name": "Vallejo Planned Parenthood",
      "address": "303 Sacramento St, Vallejo, CA 94590, United States",
      "phoneNum": "+18002307526",
      "website":
          "https://www.plannedparenthood.org/health-center/california/vallejo/94590/vallejo-health-center-2699-90200?utm_campaign=vallejo-health-center&utm_medium=organic&utm_source=local-listing"
    }
  ];

  // returns Null if some error
  // returns a list in order of distance
  List? getClinics(double usrLat, double usrLng) {
    List out = [];
    for (var clinic in Clinics) {
      out.add([calcDist(usrLat, usrLng, clinic["lat"], clinic["lng"]), clinic]);
    }
    out.sort((a, b) => a[0].compareTo(b[0]));
    return out;
  }

  // gets the distance between two points
  num calcDist(double x1, double y1, double x2, double y2) {
    return (pow((x1 - x2), 2) + pow((y1 - y2), 2));
  }
}
