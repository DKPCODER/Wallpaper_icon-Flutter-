import 'package:flutter/material.dart';

class CatBlock extends StatelessWidget {
  String ImageUrl;
  String catName;
   CatBlock({Key? key,required this.ImageUrl,required this.catName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:85,
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              ImageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            alignment:Alignment.center ,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Text(
              catName,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
