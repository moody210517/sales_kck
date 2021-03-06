

import 'package:flutter/material.dart';
import 'package:sales_kck/constants/DBHelper/OrderDBHelper.dart';
import 'package:sales_kck/constants/colors.dart';
import 'package:sales_kck/constants/app_strings.dart';
import 'package:sales_kck/model/post/SaleOrderModel.dart';
import 'package:sales_kck/services/order_service.dart';
import 'package:sales_kck/utils/Validations.dart';
import 'package:sales_kck/view/order/pages/Customer.dart';
import 'package:sales_kck/view/sale_list/partial/NoItem.dart';
import 'package:sales_kck/view/widget/InputForm.dart';

class SaleListingSynced extends StatefulWidget {

  const SaleListingSynced({Key? key}) : super(key: key);
  @override
  _SaleListingSyncedState createState() => _SaleListingSyncedState();
}

class _SaleListingSyncedState extends State<SaleListingSynced> {

  String searchKey = '';
  final myController = TextEditingController();

  List<SaleOrderModel> originalItems = <SaleOrderModel>[];
  List<SaleOrderModel> items = <SaleOrderModel>[];
  void loadItems() async{

    OrderDBHelper orderDBHelper = new OrderDBHelper();
    List<SaleOrderModel> response = await orderDBHelper.retrieveOrdersBySynced() as List<SaleOrderModel>;
    //List<SaleOrderModel> response = await getSaleOrders(context);
    if(response.length > 0){
      setState(() {
        items = response;
        originalItems = response;
      });
    }
  }

  void _printLatestValue() {
    searchItem('${myController.text}');
  }

  void searchItem(String key) {
    List<SaleOrderModel> tmp = <SaleOrderModel>[];
    originalItems.forEach((element) {
      if(element.companyCode.toLowerCase().contains(key.toLowerCase()) || element.custName.toLowerCase().contains(key.toLowerCase())  || element.custAccNo.toLowerCase().contains(key.toLowerCase()) ){
        tmp.add(element);
      }
    });
    setState(() {
      items = tmp;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(_printLatestValue);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      loadItems();
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Strings.sales_list_synced_title),
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InputForm(
                                    controller: myController,
                                    myHint: "Search Item", validateFunction: (value){
                                    return Validations.validateEmpty(value!);
                                  },
                                    onChange: (value){},
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.search, color: MyColors.textGreyColor,),
                          ],
                        ),
                        Divider(color: MyColors.greyColor,)
                      ],
                    )
                ),

                Container(
                    margin: EdgeInsets.only(top: 0),
                    child: items.length == 0 ?
                    showNoItem(context)
                        :
                    Container(
                        child: Container(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, index){
                                return _buildItem(items[index], index);
                              },
                            )
                        )
                    )

                )

              ],
            )
        ),

      )
    );
  }

  Widget _buildItem(SaleOrderModel item, int index) {

    return GestureDetector(
        onTap: () => {

        },
        child: InkResponse(
          onTap: (){
            debugPrint("render..");
            Navigator.pop(context, item.toMap());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Customer(saleOrderModel: item,))
            );
          },
          child: Container(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                child: Text('S'),
                foregroundColor: Colors.white,
              ),
              title: Text(item.custName),
              subtitle: Text(item.companyCode),
            ),
          ),
        )
    );


    // return InkResponse(
    //   onTap: () async{
    //     //Navigator.pop(context, item.toMap());
    //   },
    //   child: Container(
    //     padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
    //     //color: customers[index].isSelected  == true ? MyColors.greyColor : Colors.white,
    //     child: Row(
    //       children: [
    //         Expanded(
    //             flex: 2,
    //             child: Container(
    //               child: Text(
    //                 item.custName,
    //                 style: TextStyle(fontSize: 14),
    //               ),
    //             )
    //         ),
    //         Expanded(
    //             flex: 1,
    //             child: Container(
    //               child: Text(
    //                 item.companyCode,
    //                 style: TextStyle(fontSize: 12),
    //               ),
    //             )
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }



}
