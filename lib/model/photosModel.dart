class PhotosModel{
  String imgSrc;
  String PhotName;
  PhotosModel({required this.imgSrc,required this.PhotName});

  get photographer => null;
  
  static fromAPI2App(Map<String, dynamic> photoMap){
    return PhotosModel(
      imgSrc: photoMap["src"]["portrait"],
      PhotName: photoMap["photographer"],
    );
  }
  
}