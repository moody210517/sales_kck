import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/view/customer/ItemList.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();

}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(Assets.iconEdit) , width: 70, ),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(Strings.not_add_order, style: Theme.of(context).textTheme.headline2,),
            )
          ],
        )
      ),

      bottomNavigationBar: Container(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: LoginButton(
            title: Strings.add_item,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ItemList(pageType: "order",) ));
            },
          ),
        )
      ),

    );
  }
}
