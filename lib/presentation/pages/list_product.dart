import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import '../../models/product.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('appbarTitle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Voir le panier',
            onPressed: () {
              context.push('/cart');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchProducts(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
            final products = asyncSnapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                onTap: () => context.push('/product/${products[index].id}'),
                title: Text(products[index].title, maxLines: 1),
                subtitle: Text(
                  products[index].getPrice(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Image.network(products[index].image, width: 80),
                trailing: TextButton(
                  onPressed: () {},
                  child: Text("Ajouter".toUpperCase()),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<Product>> fetchProducts() async {
    final response = await get(Uri.parse('https://fakestoreapi.com/products'));
    //Récupérer les produits en List<Map>
    if (response.statusCode == 200) {
      final List<dynamic> products = json.decode(response.body);
      return products
          .map((product) => Product.fromMap(product as Map<String, dynamic>))
          .toList();
    }
    return Future.error("Erreur de connexion");
  }
}