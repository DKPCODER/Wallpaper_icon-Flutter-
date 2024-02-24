import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatelessWidget {
  final String imgUrl;

  const FullScreen({Key? key, required this.imgUrl}) : super(key: key);

  Future<void> setWallpaperFromFile(
      String wallpaperUrl, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloading Started...")));
    try {
      // Saved with this method.
      var file = await DefaultCacheManager().getSingleFile(wallpaperUrl);
      if (file == null) {
        return;
      }
      // Below is a method of obtaining saved image information.
      var path = file.path;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Downloaded Successfully"),
        action: SnackBarAction(
          label: "Set as Wallpaper",
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return WallpaperOptionsDialog(filePath: path);
              },
            );
          },
        ),
      ));
      print("IMAGE DOWNLOADED");
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Occurred - $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await setWallpaperFromFile(imgUrl, context);
        },
        label: Text("Set Wallpaper"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imgUrl,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class WallpaperOptionsDialog extends StatelessWidget {
  final String filePath;

  const WallpaperOptionsDialog({Key? key, required this.filePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set Wallpaper Options'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              await WallpaperManager.setWallpaperFromFile(
                filePath,
                WallpaperManager.HOME_SCREEN,
              );
              Navigator.pop(context);
            },
            child: Text('HOME SCREEN'),
          ),
          ElevatedButton(
            onPressed: () async {
              await WallpaperManager.setWallpaperFromFile(
                filePath,
                WallpaperManager.LOCK_SCREEN,
              );
              Navigator.pop(context);
            },
            child: Text('LOCK SCREEN'),
          ),
          ElevatedButton(
            onPressed: () async {
              await WallpaperManager.setWallpaperFromFile(
                filePath,
                WallpaperManager.BOTH_SCREEN,
              );
              Navigator.pop(context);
            },
            child: Text('BOTH SCREENS'),
          ),
        ],
      ),
    );
  }
}
