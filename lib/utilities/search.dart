import 'package:flutter/material.dart';

class search extends StatefulWidget {
  final Function(String) getloc;
  final Function(String) fetchData;
  const search({super.key,required this.getloc,required this.fetchData});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  TextEditingController loc=TextEditingController();
  String location="";


  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: loc,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white70,
                    ),
                    fillColor: Colors.white.withOpacity(0.3),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.6))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.6))),
                    hintText: "Your Location",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                    suffixIcon: IconButton(onPressed: loc.clear, icon: const Icon(Icons.clear)),
                    suffixIconColor: Colors.white,
                  ),
                  onSubmitted: (String value) {
                    setState(() {
                      location = value;
                      widget.getloc(location);
                      widget.fetchData(location);
                      print(location);
                    });
                  },
                ),
              );
  }
}