import 'package:flutter/material.dart';
import 'package:wallpaper_icon/views/screens/search.dart';


class SearchBar extends StatelessWidget {
  SearchBar({super.key}) ;

   TextEditingController _Searchcontroller=TextEditingController();
 



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(66, 192, 192, 192),
        border: Border.all(color: Color.fromARGB(33, 13, 5, 5)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _Searchcontroller,
              decoration: InputDecoration(
                hintText: "Search Wallpapers",
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Searchscreen(query:_Searchcontroller.text),
                ),
              );
            },
            child: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
