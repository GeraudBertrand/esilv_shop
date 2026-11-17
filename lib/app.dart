import 'dart:convert';

import 'package:esilv_shop/presentation/pages/cart_page.dart';
import 'package:esilv_shop/presentation/pages/detail_product.dart';
import 'package:esilv_shop/presentation/pages/list_product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import 'models/product.dart';

class EsilvShop extends StatelessWidget {
  EsilvShop({super.key});

  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ListProduct(),
        routes: [
          GoRoute(
            path: 'product/:id',
            builder: (context, state)  {
              final idProductNullable = int.tryParse(
                  state.pathParameters['id'] ?? ""
              ) ;
              if(idProductNullable == null){
                return Scaffold(body: Center(child: Text("Produit introuvable")));
              }

              return FutureBuilder(
                future: fetchProduct(idProductNullable),
                builder: (context, asyncSnapshot) {
                  if( asyncSnapshot.hasData && asyncSnapshot.data != null){
                    return DetailProduct(product: asyncSnapshot.data!);
                  }
                  else{
                    return const Scaffold(
                      body: Center(child: Text("Produit disponible")),
                    );
                  }
                }
              );
            }
          )
        ]
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => CartPage()
      ),
    ]
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Esilv shop",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }


  Future<Product> fetchProduct(int index) async {
    final response = await get(Uri.parse('https://fakestoreapi.com/products/$index'));

    if(response.statusCode == 200) {
      return Product.fromMap(json.decode(response.body));
    }
    return Future.error("Erreur de connexion");
  }
}
