import 'package:flutter/material.dart';

class KonsultasiDetail extends StatefulWidget {
  @override
  _KonsultasiDetailState createState() => _KonsultasiDetailState();
}

class _KonsultasiDetailState extends State<KonsultasiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Curhatan"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text("Curhatan Ku", style: TextStyle(
                  fontSize: 28,

                ),),
                padding: EdgeInsets.all(10),
              ),
              Container(
                child: Text('Commodo eiusmod sunt dolor mollit. Aute officia deserunt aute incididunt sit. Officia deserunt cupidatat id dolor dolore velit duis ullamco culpa proident quis tempor esse exercitation. Nulla tempor incididunt fugiat esse. Aliquip anim ut commodo commodo tempor. \n\nQui aute mollit ut enim nisi do ad ipsum minim pariatur mollit est irure. Qui sit officia reprehenderit adipisicing voluptate id occaecat et amet labore.Amet cillum pariatur esse elit elit. Ipsum ea dolor ex incididunt laboris aliqua consectetur in nostrud mollit ex. Lorem cupidatat nostrud duis irure deserunt officia nulla.'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              Container(
                child: Text("Jawaban", style: TextStyle(
                  fontSize: 28,

                ),),
                padding: EdgeInsets.all(10),
              ),
              Container(
                child: Text('Commodo eiusmod sunt dolor mollit. Aute officia deserunt aute incididunt sit. Officia deserunt cupidatat id dolor dolore velit duis ullamco culpa proident quis tempor esse exercitation. Nulla tempor incididunt fugiat esse. Aliquip anim ut commodo commodo tempor. \n\nQui aute mollit ut enim nisi do ad ipsum minim pariatur mollit est irure. Qui sit officia reprehenderit adipisicing voluptate id occaecat et amet labore.Amet cillum pariatur esse elit elit. Ipsum ea dolor ex incididunt laboris aliqua consectetur in nostrud mollit ex. Lorem cupidatat nostrud duis irure deserunt officia nulla.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
