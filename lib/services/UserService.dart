
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sales_kck/constants/Api.dart';
import 'package:sales_kck/constants/globals.dart';
import 'package:sales_kck/constants/storage.dart';
import 'package:dio/dio.dart';

Future<bool> login(BuildContext context,  String username, String password) async {
  ProgressDialog pr;// = new ProgressDialog(context);
  pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try {
    pr.style(
        message: "Please wait..."
    );
    await pr.show();

    Map<String, dynamic>? queryParameters = { 'username': username, 'password': password};
    var response = await Dio().post(Api.baseUrl + "/api/v1/login", queryParameters: queryParameters );
    if(jsonDecode(response.toString())['error'] != null){
      print("error");

    }else{
      print(response);
      Storage.saveUser(response.toString());
      await pr.hide();
      return true;
    }
  } catch (e) {
    debugPrint("error -- " + e.toString());
    print(e);
  }
  
  await pr.hide();
  return false;
}


Future<bool> forgotPassword(BuildContext context,  String username) async {

  ProgressDialog pr;
  pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
  try {
    pr.style(
        message: "Please wait..."
    );
    await pr.show();
    Map<String, dynamic>? queryParameters = { 'username': username };
    var response = await Dio().post(Api.baseUrl + "/api/v1/reset", queryParameters: queryParameters );
    if(jsonDecode(response.toString())['status']){
      await pr.hide();
      showToastMessage(context, jsonDecode(response.toString())['message'], "Ok");
      return true;
    }else{
      await pr.hide();
      showToastMessage(context, jsonDecode(response.toString())['message'], "Ok");
      return false;
    }
  } catch (e) {
    debugPrint("error -- " + e.toString());
    print(e);
  }
  await pr.hide();
  return false;
}



Future<bool> template(String email) async {

  var queryParameters = {
    'email': email.toString()
  };

  try{

    var uri =
    Uri.https(Api.baseUrl, '/uat/backoffice/api/resetPassword', queryParameters);

    final response = await http.get(
        uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    }
    );
    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      if(jsonRes["results"] == 200){
        return true;
      }
      return false;
    } else {
      //throw Exception('Failed to create album.');
      return false;
    }
  }on TimeoutException catch(_){
    return false;
  }on Exception catch(_){
    return false;
  }

}

