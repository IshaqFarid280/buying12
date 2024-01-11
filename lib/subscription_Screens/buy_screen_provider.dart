

import 'package:buying/premium_api_links/api_controller.dart';
import 'package:buying/user_premium_info/user_premeium_form_screens/gender_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:http/http.dart' as http;

class SubscriptionProvider extends ChangeNotifier {

  InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Future<void> performInAppPurchase(BuildContext context, userId) async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      print('In-app purchases not available on this device.');
      return;
    }
    Set<String> productIds = {'monthly'};
    ProductDetailsResponse productDetails = await _inAppPurchase.queryProductDetails(productIds);
    List<ProductDetails> products = productDetails.productDetails;
    if (products.isEmpty) {
      print('No products found.');
      return;
    }
    PurchaseParam purchaseParam = PurchaseParam(productDetails: products.first);
    bool purchaseResult = await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    if (purchaseResult) {_inAppPurchase.purchaseStream.listen((List<PurchaseDetails> purchaseDetailsList) async {
        for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
          if (purchaseDetails.status == PurchaseStatus.purchased) {
            print('Transaction Date : ${purchaseDetails.transactionDate.toString()}');
            await sendPurchaseDetailsToServer(purchaseDetails,userId).then((value) => Navigator.push(context, CupertinoPageRoute(builder: (context) => GenderSelectionScreen(userId: userId))));
          } else if (purchaseDetails.status == PurchaseStatus.error) {
            print('Purchase failed: ${purchaseDetails.error}');
          }
        }
      });
    } else {
      print('Purchase failed.');
    }
  }

  Future<void> sendPurchaseDetailsToServer(PurchaseDetails purchaseDetails,userId) async {
    DateTime transactionDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(purchaseDetails.transactionDate.toString()),);
    String formattedTransactionDate = '${transactionDateTime.year}-${_addLeadingZero(transactionDateTime.month)}-${_addLeadingZero(transactionDateTime.day)}';
    print('Transaction Date: $formattedTransactionDate');
    print('userId from function: $userId');
    final response = await http.post(
      Uri.parse('${ApiServices.basicUrl}/subscription'),
      body: {
        'user_id': userId.toString(),
        'subscription_plan': purchaseDetails.productID.toString(),
        'purchase_date': formattedTransactionDate.toString(),
      },
    );
    if (response.statusCode == 200) {
    } else {
      print('Error sending purchase details to the server: ${response.statusCode}');
    }
  }
  String _addLeadingZero(int value) {
    return value < 10 ? '0$value' : '$value';
  }
}
