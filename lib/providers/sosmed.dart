import 'package:KasihSayang/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class Sosmed with ChangeNotifier {
  List<SosmedModel> items = [
    SosmedModel(
      id: 1,
      name: "Jonodon",
      caption: "Lorem aliqua tempor duis labore.",
      imageUrl: null,
      imageFile: null,
      likes: ["Jonodon", "Frankenstein","Mona"],
    ),
    SosmedModel(
      id: 2,
      name: "Frankenstein",
      caption: "Lorem aliqua tempor duis labore.Irure labore laborum Lorem ut ex nostrud cillum nostrud officia voluptate aute non laboris sint.",
      imageUrl: 'https://media0.giphy.com/media/l41lFGgk7V6yG7ExW/source.gif',
      imageFile: null,
      likes: ["Jonodon", "Frankenstein","Mona"],
    ),
    SosmedModel(
      id: 3,
      name: "Mona",
      caption: "Rasanya asli enak!, beda sama minuman lainnya..",
      imageUrl:
          'https://instagram.fcgk10-1.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/83333941_200601588000904_6350258116216510176_n.jpg?_nc_ht=instagram.fcgk10-1.fna.fbcdn.net&_nc_cat=104&_nc_ohc=cC_2vRB2I18AX-CfsNS&oh=661808a1310ce95d0a5356f05f942328&oe=5ED966D4',
      imageFile: null,
      likes: ["Jonodon", "Frankenstein","Mona"],
    ),
  ];

  List<SosmedModel> get posts {
    return [...items];
  }

  addPost(int id, String name, String caption, String imgUrl, File imageFile) {
    items.insert(0,SosmedModel(
      id: id,
      name: name,
      caption: caption,
      imageUrl: imgUrl == null ? imgUrl : null,
      imageFile: imageFile != null ? imageFile : null,
    ));
    notifyListeners();
  }

  deletePost(int id) {
    items.removeAt(id);
    notifyListeners();
  }
likedHandle(String ){}
}


class SosmedModel {
  int id;
  String name;
  String caption;
  String imageUrl;
  File imageFile;
  List<String> likes;

  SosmedModel({this.id, this.name, this.caption, this.imageUrl, this.imageFile, this.likes});
}
