import 'package:flutter/material.dart';
import 'package:wallpaper_icon/controller/apiOper.dart';
import 'package:wallpaper_icon/model/categoryModel.dart';
import 'package:wallpaper_icon/model/photosModel.dart';
import 'package:wallpaper_icon/views/screens/fullscreen.dart';
import 'package:wallpaper_icon/views/widgets/catBlock.dart';
import 'package:wallpaper_icon/views/widgets/customappbar.dart';
import 'package:wallpaper_icon/views/widgets/searchbar.dart' as CustomSearchBar;
import 'package:progressive_image/progressive_image.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late List<PhotosModel> trendingWallList = [];
  late List<CategoryModel> categoryWallList = [];

  @override
  void initState() {
    super.initState();
    fetchTrendingWallpapers();
    getcategory();
  }
    
  bool isloading = false; 
  getSearchResults(String name) async {
    setState(() {
      isloading = true;
    });
    trendingWallList = await ApiOperations.getSearchWallpapers(name);
    setState(() {
       isloading = false;
    });
 
  }
  Future<void>getcategory()async{
    try{
      final   List<CategoryModel> categoryWallpapers = await ApiOperations.getCategoriesList();
      setState(() {
        categoryWallList = categoryWallpapers;
      });
    }catch(e){
      print('Error fetching category wallpapers: $e');
    }
  }

  Future<void> fetchTrendingWallpapers() async {
    try {
      final List<PhotosModel> trendingWallpapers =
          await ApiOperations.getTrendingWallpapers();
      setState(() {
        trendingWallList = trendingWallpapers;
      });
    } catch (e) {
      print('Error fetching trending wallpapers: $e');
    }
  }

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
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(height: 20),
                CustomSearchBar.SearchBar(),
                Container(
                  height: 120,
                  margin: EdgeInsets.only(left: 10,top: 10),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryWallList.length,
                    itemBuilder: (context, index) {
                      final category = categoryWallList[index];
                      return InkWell(
                        onTap: (){
                        getSearchResults(category.catName);
                        },
                        child: CatBlock(
                          ImageUrl: category.catImgUrl,
                          catName: category.catName,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 400,
                      ),
                      itemCount: trendingWallList.length,
                      itemBuilder: (context, index) {
                        final photo = trendingWallList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)
                                
                                
                                
                                 => FullScreen(
                                  imgUrl: photo.imgSrc,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: photo.imgSrc,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: ProgressiveImage(
                                placeholder: AssetImage('assets/images/img.webp'),
                                thumbnail: NetworkImage(photo.imgSrc),
                                image: NetworkImage(photo.imgSrc),
                                width: 200,
                                height: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
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
