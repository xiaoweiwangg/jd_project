import 'package:flutter/material.dart';

class CartCont extends StatefulWidget {
  @override
  _CartContState createState() => _CartContState();
}

class _CartContState extends State<CartCont> {
  @override
  Widget build(BuildContext context) {
    return Text('CartCont');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('cart initstate ....');
  }
}
