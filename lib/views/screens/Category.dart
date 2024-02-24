import 'package:flutter/material.dart';
import 'package:wallpaper_icon/views/widgets/customappbar.dart'; 
import 'package:wallpaper_icon/views/widgets/searchbar.dart' as CustomSearchBar; 
import 'package:wallpaper_icon/views/widgets/catBlock.dart';
import 'package:wallpaper_icon/controller/apiOper.dart';

class Categoryscreen extends StatefulWidget {
   String catImgUrl;
  String catName;

  Categoryscreen({Key? key, required this.catImgUrl, required this.catName}) : super(key: key);

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const CustomAppBar(), 
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                widget.catImgUrl, // Use catImgUrl from widget
                height: 150,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.catName, // Use catName from widget
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10), 
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 400, 
                ),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(5), 
                  child: Image.network(
                    widget.catImgUrl, // Use catImgUrl from widget
                    fit: BoxFit.cover,
                  ),
                ),
                itemCount: 30, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
