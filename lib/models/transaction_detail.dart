import './order.dart';

class TransactionDetail {
  int id;
  String invoice;
  int idCategory;
  int idKendaraan;
  String typeKendaraan;
  String merkKendaraan;
  String brandKendaraan;
  String tahunKendaraan;
  String complaint;
  String photo;
  int idOutlet;
  String outletName;
  String outletAddress;
  // double outletLat;
  // double outletLng;
  String address;
  String detailAddress;
  double lng;
  double lat;
  int total;
  int ship;
  DateTime date;
  String status;
  String jenis;
  List<Order> order;

  TransactionDetail({
    this.id,
    this.idCategory,
    this.total,
    this.outletName,
    this.status,
    this.lng,
    this.lat,
    this.address,
    this.brandKendaraan,
    this.complaint,
    this.date,
    this.detailAddress,
    this.idKendaraan,
    this.idOutlet,
    this.invoice,
    this.jenis,
    this.merkKendaraan,
    this.outletAddress,
    // this.outletLat,
    // this.outletLng,
    this.photo,
    this.ship,
    this.tahunKendaraan,
    this.typeKendaraan,
    this.order,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    try {
      List<Order> _tmp = [];
      print(json['detail'].length);
      for (var i = 0; i < json['detail'].length; i++) {
        final _order = json['detail'][i];
        _tmp.add(
          Order(
            id: _order['id'],
            name: _order['name'],
            price: _order['price'],
            idProduct: _order['id_mx_ms_product'],
            qty: _order['qty'],
            subtotal: _order['subtotal'],
          ),
        );
      }

      var res = TransactionDetail(
        id: json['id'],
        address: json['address'],
        idKendaraan: json['id_mx_tb_kendaraan'],
        brandKendaraan: json['mx_tb_kendaraan_brand'],
        merkKendaraan: json['mx_tb_kendaraan_merk'],
        tahunKendaraan: json['mx_tb_kendaraan_tahun'].toString(),
        typeKendaraan: json['mx_tb_kendaraan_type'],
        complaint: json['complaint'],
        date: json['created_at'],
        detailAddress: json['detail_address'],
        idCategory: json['id_mx_ms_category_service'],
        idOutlet: json['id_mx_ms_outlets'],
        invoice: json['invoice'],
        jenis: json['jenis'],
        lat: double.parse(json['lat']),
        lng: double.parse(json['lng']),
        outletAddress: json['mx_ms_outlets_address'],
        // outletLat: double.parse(json['mx_ms_outlet_lat']),
        // outletLng: double.parse(json['mx_ms_outlet_lng']),
        outletName: json['mx_ms_outlets_name'],
        photo: json['photo'],
        ship: json['ship'],
        status: json['status'],
        total: json['total'],
        order: _tmp,
      );
      print('res');
      print(res);
      return res;
    } catch (e) {
      print('err');
      print(e);
    }
  }
}
