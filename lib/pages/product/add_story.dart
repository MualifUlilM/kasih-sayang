import 'dart:io';

import 'package:flutter/material.dart';
import 'package:KasihSayang/providers/sosmed.dart';
import 'package:KasihSayang/providers/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  static const routingName = "Add Posting";
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController captionController = TextEditingController();

  File _image;
  var image;
  bool isImageEmpty = true;

  @override
  Widget build(BuildContext context) {
    final sosmedProvider = Provider.of<Sosmed>(context);
    final userProvider = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Berbagi Cerita"),
        // centerTitle: true,
        actions: <Widget>[
          FlatButton(onPressed: (){
            if (captionController.text != '') {
              sosmedProvider.addPost(5, userProvider.name, captionController.text, null, image);
            Navigator.pop(context);
            }
          }, child: Text("Posting", style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),))
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: isImageEmpty ? MediaQuery.of(context).size.height * 0.89 : MediaQuery.of(context).size.height * 0.52,
                  decoration: BoxDecoration(
                    // color: Colors.pink
                  ),
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: captionController,
                    maxLines: 100,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Apa Yang Anda Pikirkan ?"
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.07),
                  child: Stack(
                    children: <Widget>[
                      isImageEmpty ? Container():Image.file(image),
                      Positioned(right: 0, child: FlatButton(onPressed: (){
                        setState(() {
                          image = null;
                          isImageEmpty = true;
                        });
                      }, child: Container(
                        height: MediaQuery.of(context).size.height*0.05,
                        width: MediaQuery.of(context).size.width*0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Icon(Icons.close),
                      ))),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.07,
                        // padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.grey[300], width: 1)),
                          color: Colors.white,
                        ),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.image, color: Theme.of(context).primaryColor,), onPressed: ()async{
                          _image = await ImagePicker.pickImage(source: ImageSource.gallery);
                          setState(() {
                           image = _image;
                           isImageEmpty = false; 
                          });
                          print(image);
                        }),
                        IconButton(icon: Icon(Icons.location_on, color: Theme.of(context).primaryColor), onPressed: (){})
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}