import 'package:flutter/material.dart';
import 'package:app/constants/icons.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed("/searchScreen");
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 10),
        color: Colors.grey[350],
        child: TextField(
          decoration: InputDecoration(
            suffixIcon: searchIcon,
            filled: true,
            fillColor: Colors.grey[350],
            labelText: "Search for meals",
            contentPadding: EdgeInsets.only(left: 30.0),
            enabled: false,
          ),
        ),
      ),
    );
  }
}
