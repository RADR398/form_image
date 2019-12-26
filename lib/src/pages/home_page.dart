import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/provider.dart';
import 'package:formvalidation/src/models/product.dart';
import 'package:formvalidation/src/providers/product_provider.dart';

class HomePage extends StatelessWidget {

  final ProductProvider provider = ProductProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
          title: Text('Home')
      ),
      body: _createList(),
      floatingActionButton: _childButton(context),
    );
  }

  Widget _childButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.white,),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'product'),
    );
  }

  Widget _createList() {
    return FutureBuilder(
      future: provider.getProduct(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;
          return ListView.builder(
            itemBuilder: (BuildContext context, int index )=>createItem(context,products[index]),
            itemCount: products.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  Widget createItem(BuildContext context,ProductModel product){
    return Dismissible(
      key: UniqueKey(),
      child: ListTile(
        title: Text('${product.title} - ${product.value}'),
        subtitle: Text('${product.id}'),
        onTap: ()=>Navigator.pushNamed(context, 'product',arguments: product),
      ),
      onDismissed: (DismissDirection direction)async {
        await provider.deleteProduct(product.id);
      },
    );
  }
}