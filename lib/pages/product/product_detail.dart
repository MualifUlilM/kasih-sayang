import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart';
import '../../providers/user.dart';
import '../../providers/cart.dart';
import 'package:maxiaga/models/produk.dart';
import 'package:maxiaga/pages/product/pesanan.dart';
import './product_grid.dart';
import './cart.dart';
import '../../widgets/badge.dart';

class ProductDetailPage extends StatefulWidget {
  final int outletId;
  final String name;
  final String address;
  ProductDetailPage({
    Key key,
    @required this.outletId,
    @required this.name,
    this.address,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLoading = true;
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Products>(context)
          .fetchAndSet(
              Provider.of<User>(context, listen: false).token, widget.outletId)
          .then((res) {
        print('aw');
        print(res);
        // set state loading
        setState(() {
          isLoading = false;
          isInit = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height / 4,
              floating: true,
              // snap: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  // centerTitle: true,
                  title: Text(
                    '${widget.name}',
                    style: Theme.of(context).primaryTextTheme.title,
                  ),
                  background: Stack(
                    children: <Widget>[
                      Image.asset(
                        'lib/assets/images/spbu.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xCC000000),
                              const Color(0x00000000),
                              const Color(0x00000000),
                              const Color(0xCC000000),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              actions: <Widget>[
                Consumer<Cart>(
                  builder: (_, cart, _2) => Badge(
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      tooltip: 'Pesan produk',
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartPage.routeName);
                      },
                    ),
                    value: cart.itemCount.toString(),
                  ),
                ),
              ],
            )
          ];
        },
        body: Consumer<Products>(builder: (_, products, _2) {
          // jika belum selesai
          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // jika selesai
            return ProductGrid(widget.outletId, widget.name, products.products);
          }
        }),
      ),
    );
  }
}
