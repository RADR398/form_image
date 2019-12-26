import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/product.dart';
import 'package:formvalidation/src/providers/product_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductModel model  = ProductModel();
  bool _saved = false;

  final ProductProvider provider = ProductProvider();

  @override
  Widget build(BuildContext context) {

    final ProductModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData != null){
      model = prodData ;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){},
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  createName(),
                  createPrice(),
                  createAvailable(),
                  createButton(),
                ],
              ),
            ),
            padding: EdgeInsets.all(15),
          )
      ),
    );
  }

  Widget createName() {
    return TextFormField(
      initialValue: model.title,
      onSaved: (String value)=>model.title = value,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      validator: (String value){
        if(value.length < 3 ){
          return 'Ingrese el nombre del producto';
        }else {
          return null;
        }
      },
    );
  }

  Widget createPrice() {
    return TextFormField(
      initialValue: model.value.toString(),
      onSaved: (String value )=>model.value = double.parse(value),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      validator: (String value){
        if(utils.isNumeric(value)){
          return null;
        }else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget createAvailable(){
    return SwitchListTile(
      activeColor: Colors.deepPurple,
      value: model.available,
      title: Text('Disponible'),
      onChanged: (value)=>setState((){print(value);model.available = value;}),
    );
  }

  Widget createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      onPressed: _saved ? null:_onSubmit,
      label: Text('Guardar'),
      textColor: Colors.white,
      icon: Icon(Icons.save),
    );
  }

  void _onSubmit() {
    if(!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _saved = true;
    });

    if(model.id == null){
      provider.createProduct(model);
    }else{
      provider.editProduct(model);
    }
    showSnackBar('Registro Guardado');

    Navigator.pop(context);

  }

  void showSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
