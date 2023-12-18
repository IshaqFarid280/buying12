import 'dart:convert';
import 'package:buying/premiium_all_exercises_categories/CategoryProvider.dart';
import 'package:buying/premiium_all_exercises_categories/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  // InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  runApp(MyAppp());
}
//
// void main() {
//   InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryProvider(),
      child: MaterialApp(
        title: 'Your App Title',
        home: YourHomePage(),
      ),
    );
  }
}

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Upgrade to Premium!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await performInAppPurchase();
              },
              child: Text('Subscribe to Premium'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performInAppPurchase() async {
    final InAppPurchase _inAppPurchase = InAppPurchase.instance;
    final bool isAvailable = await _inAppPurchase.isAvailable();

    if (!isAvailable) {
      print('In-app purchases not available on this device.');
      return;
    }

    Set<String> productIds = {'monthly'};
    ProductDetailsResponse productDetails =
    await _inAppPurchase.queryProductDetails(productIds);
    List<ProductDetails> products = productDetails.productDetails;

    if (products.isEmpty) {
      print('No products found.');
      return;
    }

    PurchaseParam purchaseParam = PurchaseParam(productDetails: products.first);
    bool purchaseResult =
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);

    if (purchaseResult) {
      _inAppPurchase.purchaseStream
          .listen((List<PurchaseDetails> purchaseDetailsList) async {
        for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
          if (purchaseDetails.status == PurchaseStatus.purchased) {
            print('Product ID: ${purchaseDetails.productID}');
            print('Purchase verification Data: ${purchaseDetails.verificationData.localVerificationData}');
            print('Purchase ID: ${purchaseDetails.purchaseID}');
            print('Purchase Status: ${purchaseDetails.status}');
            print('Purchase Date: ${purchaseDetails.transactionDate.toString()}');
            print('Purchase error: ${purchaseDetails.error}');
            print('Purchase PendingCompletePurchase : ${purchaseDetails.pendingCompletePurchase}');
            // Send purchase details to your server
            // Map<String, dynamic> verificationData = purchaseDetails.verificationData.serverVerificationData;
            // String purchaseToken = verificationData['purchaseToken'];
            // print('Purchase Token: $purchaseToken');
            await sendPurchaseDetailsToServer(purchaseDetails);

            await verifySubscription(purchaseDetails);
            break;
          } else if (purchaseDetails.status == PurchaseStatus.error) {
            print('Purchase failed: ${purchaseDetails.error}');
            // Handle purchase failure
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Subscription Failed'),
                content: Text('Please try again.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      });
    } else {
      print('Purchase failed.');
    }
  }

  Future<void> sendPurchaseDetailsToServer(PurchaseDetails purchaseDetails) async {
    final response = await http.post(
      Uri.parse('https://your-server/purchase'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'purchaseId': purchaseDetails.purchaseID,
        'productId': purchaseDetails.productID,
        'purchaseToken': purchaseDetails.purchaseID, // Use purchaseID or adjust based on your server needs
        'purchaseDate': purchaseDetails.transactionDate.toString(),
        // Add any other relevant data you need to send to the server
      }),
    );
    if (response.statusCode == 200) {
      print('Purchase details sent to the server successfully');
    } else {
      print('Error sending purchase details to the server: ${response.statusCode}');
    }
  }

  Future<void> verifySubscription(PurchaseDetails purchaseDetails) async {
    // Implement subscription verification logic on your server
    // ...
  }
}

class PremiumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Premium Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Premium Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
