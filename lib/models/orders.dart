import 'package:flutter/foundation.dart';
import '../api.dart';

class Orders {
  String token = '';
  String address = '';
  int idOutlet = 0;
  String detailAddress = '';
  double lng = 0.0;
  double lat = 0.0;
  int idCategory = 0;
  String complaint = '';
  List<Map<String, dynamic>> detail = [];
  List<String> photos = [];
  int idKendaraan = 0;

  Orders({
    @required this.token,
    @required this.address,
    @required this.lat,
    @required this.lng,
    this.detailAddress,
    this.idCategory,
    this.complaint,
    this.detail,
    this.idKendaraan,
    this.idOutlet,
    this.photos,
  });

  Future<Map<String, dynamic>> submitServices() async {
    Map<String, dynamic> _result;
    try {
      await Api()
          .postService(
        idCategory,
        idKendaraan,
        idOutlet,
        address,
        detailAddress,
        lat,
        lng,
        complaint,
        photos,
        token,
      )
          .then((res) {
        if (res.data['api_status'] == 1) {
          _result = {
            'success': true,
            'message': res.data['api_message'],
          };
        } else {
          _result = {
            'success': false,
            'message': res.data['api_message'],
          };
        }
      });
    } catch (e) {
      _result = {
        'success': false,
        'message': e.toString(),
      };
    }
    return _result;
  }
}
