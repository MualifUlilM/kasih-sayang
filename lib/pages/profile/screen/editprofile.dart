import 'package:KasihSayang/appBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../my_home_page.dart';
import '../../../providers/user.dart';

class EditProfile extends StatefulWidget {
  static const routingName = 'editProfile';
  String name;
  String email;
  String phone;
  String kota;
  String gender;

  EditProfile({
    @required this.name,
    @required this.email,
    @required this.phone,
    this.kota,
    @required this.gender,
  });
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  List jk = ['Laki-Laki', 'Perempuan'];
  File _image;

  String _valueSelected;

  Dio dio = Dio();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _kotaController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordConfirmController = new TextEditingController();
  String _gender;

  void setInitialValue() {
    _nameController.text = widget.name;
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    _kotaController.text = widget.kota;
    _valueSelected = widget.gender == 'L' ? 'Laki-Laki' : 'Perempuan';
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 78);
    print("before compress " + image.lengthSync().toString());

    setState(() {
      _image = image;
      print(_image);
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);

    ProgressDialog pr = new ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );

  pr.style(
      message: 'Tunggu Sebentar . . .',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarBikin.colors[0],
        title: Text(
          "Edit Profil",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(30),
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: _image == null
                            ? NetworkImage(userProvider.photo)
                            : FileImage(_image),
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                      ),
                      FittedBox(
                        child:Text(
                            "Ganti Foto",
                            style:
                                TextStyle(fontSize: 18, color: Colors.grey[400]),
                          ),
                      )
                    ],
                  ),
                  onPressed: () {
                    getImage();
                  },
                )),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 120,
                          padding: EdgeInsets.only(right: 20),
                          child: Text("Nama"),
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: _nameController,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 120,
                          padding: EdgeInsets.only(right: 20),
                          child: Text("Jenis Kelamin"),
                        ),
                        Flexible(child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(),
                              isEmpty: _valueSelected == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _valueSelected,
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _valueSelected = newValue;
                                      if (_valueSelected == 'Laki-Laki') {
                                        _gender = 'L';
                                      } else {
                                        _gender = 'P';
                                      }
                                      print(_gender);
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: <String>['Laki-Laki', 'Perempuan']
                                      .map((String value) {
                                    return new DropdownMenuItem(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 120,
                          padding: EdgeInsets.only(right: 20),
                          child: Text("Email"),
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: _emailController,
//                            initialValue:preferences.getString('email'),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 120,
                          padding: EdgeInsets.only(right: 20),
                          child: Text("Telepon"),
                        ),
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneController,
//                            initialValue: preferences.getString('phone'),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 120,
                          padding: EdgeInsets.only(right: 20),
                          child: Text("Status"),
                        ),
                        Flexible(
                          child: TextFormField(
                            // controller: _kotaController,
                           initialValue: 'Jomblo',
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 120,
                          padding: EdgeInsets.only(right: 20),
                          child: Text("Kota"),
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: _kotaController,
//                            initialValue: 'ajfsnaksj',
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 120,
                          padding: EdgeInsets.only(right: 20),
                          child: Text("Password"),
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: _passwordController,
//                            validator: (value){
//                              value != _passwordConfirmController.text ? 'Password tidak sama' : '';
//                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 120,
                          padding: EdgeInsets.only(right: 20),
                          child: Text("Password confirmation"),
                        ),
                        Flexible(
                          child: TextFormField(
//                            validator: (value){
//                              value != _passwordController.text ? 'Password tidak sama' : '';
//                            },
                              ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppBarBikin.colors[1],
                      borderRadius: BorderRadius.circular(2)),
                  child: Center(
                    child: Text("SIMPAN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  )),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  print('pressed');
                  pr.show();
                  userProvider.postEditProfile(
                    userProvider.token, 
                    _nameController.text, 
                    _image, 
                    _emailController.text, 
                    _phoneController.text, 
                    _kotaController.text, 
                    _passwordController.text).then((onValue){pr.hide();Navigator.pop(context);});
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
