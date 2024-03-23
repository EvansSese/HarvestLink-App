import 'package:flutter/material.dart';

Widget largeTextWhite(string) {
  return Text(
    string,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 22.0,
    ),
  );
}

Widget largeTextBlack(string) {
  return Text(
    string,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 22.0,
    ),
  );
}

Widget headerTextBlack(string) {
  return Text(
    string,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.bold
    ),
  );
}

Widget subHeaderTextBlack(string) {
  return Text(
    string,
    style: const TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold
    ),
  );
}

Widget mediumTextWhite(string) {
  return Text(
    string,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 18.0,
    ),
  );
}

Widget mediumTextBlack(string) {
  return Text(
    string,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 18.0,
    ),
  );
}

Widget smallTextWhite(string) {
  return Text(
    string,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 14.0,
    ),
  );
}

Widget smallTextBlack(string) {
  return Text(
    string,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 14.0,
    ),
  );
}
