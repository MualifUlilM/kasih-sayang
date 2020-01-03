import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Api {
  Response response;
  Dio dio = new Dio();
  // static const baseUrl = 'https://dev.maxiaga.com/api/';
    static const baseUrl = 'https://admin.maxiaga.com/api/';

  Future<Response> reqApi({
    @required String method,
    @required String url,
    Map<String, dynamic> data,
    Map<String, dynamic> queryParameters,
  }) async {
    dio.options.baseUrl = baseUrl.toString();
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;

    response = await dio.request(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(method: method),
    );

    return response;
  }

  Future<Response> fetchArticles(int offset, int perPage) async {
    offset = offset == null ? 0 : offset;
    await reqApi(
        method: 'GET',
        url: 'http://energibangsa.id/wp-json/wp/v2/posts',
        queryParameters: {
          "_fields": "link,title,jetpack_featured_media_url",
          "per_page": perPage,
          "offset": offset,
        });

    return response;
  }

  Future<Response> fetchProducts(String token, int spbuId) async {
    response = await Api().reqApi(
      method: 'GET',
      url: 'get_product',
      queryParameters: {
        "id_mx_ms_outlets": spbuId,
        "token": token,
      },
    );

    return response;
  }

  Future<Response> checkLogin(String token, double lng, double lat) async {
    response = await Api().reqApi(
      method: 'GET',
      url: 'get_token',
      queryParameters: {
        "api_token": token,
        "lng": lng,
        "lat": lat,
      },
    );

    return response;
  }

  Future<Response> getTransactions(String token, int page) async {
    response = await Api()
        .reqApi(method: "GET", url: "get_transaction", queryParameters: {
      "page": page,
      "token": token,
    });

    return response;
  }

  Future<Response> getTransactionDetail(String token, int id) async {
    response = await Api().reqApi(
      method: "GET",
      url: "get_transaction_detail",
      queryParameters: {
        "id": id,
        "token": token,
      },
    );

    return response;
  }

  Future<Response> postService(
    int idCategory,
    int idKendaraan,
    int idOutlet,
    String address,
    String detailAddress,
    double lat,
    double lng,
    String complaint,
    List<String> photos,
    String token,
  ) async {
    response = await Api().reqApi(method: 'POST', url: 'post_order', data: {
      "id_mx_ms_category_service": idCategory,
      "id_mx_tb_kendaraan": idKendaraan,
      "id_mx_ms_outlets": idOutlet,
      "address": address,
      "detail_address": detailAddress,
      "lng": lng,
      "lat": lat,
      "complaint": complaint,
      "photo": photos,
      "token": token,
    });

    return response;
  }

  Future<Response> postOrder(
    String token,
    int outletId,
    String address,
    String detailAddress,
    double lng,
    double lat,
    List<Map<String, dynamic>> details,
  ) async {
    response = await Api().reqApi(
      method: 'POST',
      url: 'post_order',
      data: {
        "token": token,
        "id_mx_ms_outlets": outletId,
        "address": address,
        "detail_address": detailAddress,
        "lng": lng,
        "lat": lat,
        "detail": details,
      },
    );

    return response;
  }

  Future<Response> checkShip(
    String token,
    double lat,
    double lng,
    int outletId,
  ) async {
    response = await Api().reqApi(
      method: 'GET',
      url: 'get_check_ship',
      queryParameters: {
        "token": token,
        "outletId": outletId,
        "lat": lat,
        "lng": lng,
      },
    );

    return response;
  }

  Future<Response> postAddKendaraan(
    int id,
    String merk,
    String brand,
    String tahun,
    String token,
  ) async {
    response = await Api().reqApi(
      method: 'POST',
      url: 'post_add_kendaraan',
      data: {
        'type': id,
        'merk': merk,
        'brand': brand,
        'tahun': tahun,
        'token': token,
      }
    );
    return response;
  }

}
