import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_icon/model/categoryModel.dart';
import 'package:wallpaper_icon/model/photosModel.dart';
import 'package:wallpaper_icon/views/screens/search.dart';
import 'dart:math';
class ApiOperations {
  static Future<List<PhotosModel>> getTrendingWallpapers() async {
  List<PhotosModel> trendingWallpapers = [];
   // ignore: unused_local_variable
  List<PhotosModel> searchWallpapers= [];
   List<CategoryModel> cateogryModelList = [];

// Initialize the list

    // Perform HTTP GET request to fetcwallpapers
    await http.get(
      Uri.parse("https://api.pexels.com/v1/curated?"),
      headers: {
        "Authorization": "CAeA6C1r7N8CidPoWgBffXR22sJsjBW9P2MjXWLMRbnroUDjJZtlQLeK", // Replace with your actual API key
      },
    ).then((response) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> photos = jsonData["photos"];
      photos.forEach((element) {
        trendingWallpapers.add(PhotosModel.fromAPI2App(element));
      });
    });

    return trendingWallpapers; // Return the list of trending wallpapers
  }
  static Future<List<PhotosModel>> getSearchWallpapers(String query) async {
     List<PhotosModel> searchWallpapersL= [];

    await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30"),
      headers: {
        "Authorization": "CAeA6C1r7N8CidPoWgBffXR22sJsjBW9P2MjXWLMRbnroUDjJZtlQLeK", // Replace with your actual API key
      },
    ).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
     searchWallpapersL.clear();
      photos.forEach((element) {
        searchWallpapersL.add(PhotosModel.fromAPI2App(element));
      });
    });

    return searchWallpapersL; 
  }
  static List<CategoryModel> getCategoriesList() {
     List<CategoryModel> cateogryModelList = [];
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotosModel photoModel =
          (await getSearchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }



}
 

