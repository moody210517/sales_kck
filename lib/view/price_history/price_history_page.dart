

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/assets.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/CustomerModel.dart';
import 'package:sales_kck/model/post/ItemModel.dart';
import 'package:sales_kck/view/customer/CustomerList.dart';
import 'package:sales_kck/view/customer/ItemList.dart';
import 'package:sales_kck/view/widget/LoginButton.dart';

class PriceHistory extends StatefulWidget {
  const PriceHistory({Key? key}) : super(key: key);
  @override
  _PriceHistoryState createState() => _PriceHistoryState();
}

class _PriceHistoryState extends State<PriceHistory> {

  List<CustomerModel> customerModels = <CustomerModel>[];
  String companyName = Strings.company_name;
  String itemName = Strings.item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.price_history),
      ),

      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(Strings.customer, style: Theme.of(context).textTheme.headline2 , ),
            InkWell(
              onTap: () async{
                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList() ));
                if(result != null){
                  setState(() {
                    CustomerModel customerModel = CustomerModel.fromMap(result);
                    setState(() {
                      companyName = customerModel.name;
                    });
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: 10) ,
                child: Row(
                  children: [
                    Expanded(child:  Text(companyName , style: Theme.of(context).textTheme.bodyText2 ), ) ,
                    Icon(Icons.search)
                  ],
                ),
              ),
            ),
            Divider(color: MyColors.greyColor,),

            Text(Strings.item_listing, style: Theme.of(context).textTheme.headline2 , ),
            InkWell(
              onTap:() async{
                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ItemList(pageType: "price_history",) ));
                if(result != null){
                  setState(() {
                    ItemModel itemModel = ItemModel.fromMap(result);
                    setState(() {
                      itemName = itemModel.code;
                    });
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: 10) ,
                child: Row(
                  children: [
                    Expanded(child:   Text( itemName , style: Theme.of(context).textTheme.bodyText2 ), ) ,
                    Icon(Icons.search)
                  ],
                ),
              )
            ),
            Divider(color: MyColors.greyColor,),

            Container(
              child: LoginButton(
                title: Strings.search,
                isActive: companyName != Strings.company_name &&  itemName != Strings.item ? true: false,
                onPressed: (){
                },
              ),
            ),

            customerModels.length > 0 ?
                Container() :
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Image(image: AssetImage(Assets.iconEdit) , width: 70,),
                  Text(Strings.no_record, style: TextStyle(color: MyColors.textBorderColor ))
                ],
              ),
            ),

          ],
        ),
      ),

    );
  }

}
