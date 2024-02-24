import 'package:flutter/material.dart';
import 'package:wallpaper_icon/controller/apiOper.dart';
import 'package:wallpaper_icon/model/photosModel.dart';
import 'package:wallpaper_icon/views/screens/fullscreen.dart';
import 'package:wallpaper_icon/views/widgets/customappbar.dart'; 
import 'package:wallpaper_icon/views/widgets/searchbar.dart' as CustomSearchBar; 

class Searchscreen extends StatefulWidget {
   String query;
   String title;

  Searchscreen({Key? key, required this.query, this.title = ''}) : super(key: key);

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  late List<PhotosModel> searchResults = [];
  bool isLoading = true;
  
  getSearchResults() async {
    searchResults = await ApiOperations. getSearchWallpapers(widget.query);
    setState(() {
       isLoading = false;
    });
 
  }

   @override
  void initState() {
    super.initState();
    getSearchResults(); 
  }



  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(), 
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CustomSearchBar.SearchBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10), 
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 400, 
                ),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                      final photo =  searchResults[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreen(
                                  imgUrl: photo.imgSrc,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: photo.imgSrc,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                photo.imgSrc,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      height: 800,
                      width: 50,
                      searchResults[index].imgSrc,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
