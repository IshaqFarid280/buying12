import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'buy_screen_provider.dart';


class SubscriptionScreen extends StatelessWidget {
  final int userId ;
  SubscriptionScreen({required this.userId});
  @override
  Widget build(BuildContext context) {
    var subscriptionModel = Provider.of<SubscriptionProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Upgrade to Premium for User ID: ${userId}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await subscriptionModel.performInAppPurchase(userId);
              },
              child: Text('Subscribe to Premium'),
            ),
          ],
        ),
      ),
    );
  }
}
