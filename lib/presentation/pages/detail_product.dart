
import 'package:esilv_shop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/cart.dart';

class DetailProduct extends ConsumerWidget {
  final Product product;
  const DetailProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(product.title),
        actions: [
          IconButton(
            icon: Badge.count(
                count: ref.watch(cartProvider).length,
                maxCount: 9,
                child: Icon(Icons.shopping_cart_outlined)
            ),
            tooltip: 'Voir le panier',
            onPressed: () {
              context.push('/cart');
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black12,
            child: Image.network(
              product.image,
              width: MediaQuery.of(context).size.width,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(product.getPrice()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(product.description),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(product.category, style: Theme.of(context).textTheme.headlineSmall),
          ),

          if(ref.watch(cartProvider).any((p) => p.id == product.id))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Chip(label : Text("Déjà dans le panier")),
            )
          ,
          Spacer(flex: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FilledButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Ajouté au panier !"),
                      duration: Duration(seconds: 1),
                    )
                  );
                },
                child: Text("Ajouter au panier"),
              ),
            ),
          ),
          Spacer(),
        ],
      )
    );
  }
}
