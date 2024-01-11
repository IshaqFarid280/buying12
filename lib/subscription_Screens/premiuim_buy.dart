import 'package:buying/bottomNavigationBar.dart';
import 'package:buying/consts/colors.dart';
import 'package:buying/user_premium_info/user_premeium_form_screens/gender_selection_screen.dart';
import 'package:buying/widget/buttons.dart';
import 'package:buying/widget/textwidgets.dart';
import 'package:flutter/cupertino.dart';
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
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: LeadingIcon(),
        title: largeText(title: 'Subscription')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   'Upgrade to Premium for User ID: ${userId}',
            //   style: TextStyle(fontSize: 20),
            // ),
            Container(
              width: MediaQuery.of(context).size.width*0.6,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: goldenColor

                  ),
                  onPressed: ()  {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => GenderSelectionScreen(userId: userId)));

                  },
                  child: normalText(title: 'Form Screen', textSize: 14.0)
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width*0.6,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: goldenColor

                  ),
                  onPressed: ()  {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => BottomNavigationScreen(userId: userId)));

                  },
                  child: normalText(title: 'Routine Screen Screen', textSize: 14.0)
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width*0.6,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    backgroundColor: goldenColor

                ),
                onPressed: () async {
                  await subscriptionModel.performInAppPurchase(context, userId);
                },
                child: normalText(title: 'Subscribe to Premium', textSize: 14.0)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
