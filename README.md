# sales_kck

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Generate  App icons automatically ( run below commands one by one.)
    flutter pub get
    flutter pub run flutter_launcher_icons:main

Ok I explain:

Making sales order > send to autocount > autocount create invoice > mobile app can print temp receipt of the sales order

You can check in DB and old app code

There is this flow

Temp receipt is tied to sales order number and invoice number

So making sales order and sync is one way data transfer, data from device is send to autocount.

Synced sales order and Printing temporary receipt is 2 way data transfer, from autocount to device and device to autocount


So for example I record a sale on app from customer A on order number #123 data is sent o autocount and invoice created

And when customer make payment I create temporary receipt on the app. It is sent to autocount. Sometimes customer make partial payment. So whatever amount temp receipt is made will update in autocount and balance will show in autocount and on device


Hi Carl issues found:

1. Remember me at login not working. Need to enter user and pass everytime. see password button also not working
2.  Sales are not captured by autocount. where is the sales synced to?
3.  Sales order number need to be YYMMDDXX0000 , XX use alphabets. and the 4 digits need to be continuous number like 1001,1002,1003 etc
4. Temporary Receipt please follow sample receipt i provided. Means device to generate TR Number. Follow format of sample.
Also in temp receipt to include invoice number. see sample. invoice number is generated when sales order is synced with autocount.
and when temporary receipt is issued and synced it will update payment amount autocount invoice
right now major issue is sales order not captured in autocount, hence there is no invoice created in autocount
Ashraf, 5:42 PM
invoice number is generated when sales order is synced with autocount. --> this is done manually by our accounts ppl
sales order sent to autocount and our staff will create the invoice for the sales order, then only sales person can print temp receipt
Ashraf, 5:55 PM
TR Number & SO Number generated by device - refer format on sample
Invoice number generated by accounts team via autocount
TR is connected to SO and Invoice



