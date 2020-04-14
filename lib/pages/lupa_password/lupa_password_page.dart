import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routingName = 'forgotPasswordPage';
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Container(
            //   padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            // ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                // color: Theme.of(context).primaryColor,
                color: Colors.blue
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,),onPressed: ()=>Navigator.pop(context),)
                    ],
                  ),
                  Container(child: Image.asset('lib/assets/images/maxiaga_putih.png', scale: 10,), margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Text(''),
                  ),
                  Container(child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'EmailAnda@mail.com',
                      labelText: 'Email'
                    ),
                  ), padding: EdgeInsets.all(10),margin: EdgeInsets.all(30),),
                  RaisedButton(
                    color: Colors.blue[400],
                    onPressed: (){},
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Center(
                        child: Text('Kirim', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}