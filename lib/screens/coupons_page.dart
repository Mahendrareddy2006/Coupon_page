import 'package:flutter/material.dart';
import 'package:spacez_coupons_page/cardDetails/coupons_card.dart';



class CouponsPage extends StatelessWidget {
  void _showSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Action successful! — This action is for demo purposes only.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardBgColor = Color(0xFFF5F5F5);
    final priceTagColor = Color(0xFFA8602A);
    final greenBannerColor = Color(0xFF33814F);
    final appBarTextColor = Color(0xFFA8602A);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.home, color: appBarTextColor),
            SizedBox(width: 8),
            Text(
              'SPACEZ',
              style: TextStyle(
                color: appBarTextColor,
                fontFamily: 'Cinzel',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Icon(Icons.menu, color: appBarTextColor),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 20,),
                  Text(
                    'Coupons',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            CouponCard(
              priceTagColor: priceTagColor,
              cardBgColor: cardBgColor,
              onApply: () => _showSuccess(context),
            ),
            CouponCard(
              priceTagColor: priceTagColor,
              cardBgColor: cardBgColor,
              onApply: () => _showSuccess(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Payment offers:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CouponCard(
              priceTagColor: priceTagColor,
              cardBgColor: cardBgColor,
              onApply: () => _showSuccess(context),
            ),
            Container(
              color: greenBannerColor,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                'Book now & Unlock exclusive rewards!',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('₹19,500', style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red,
                            fontSize: 14,
                          ),),
                          SizedBox(width: 10,),
                          Text('₹16,000 for 2 nights', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          Text('24 Apr - 26 Apr | 18 guests', style: TextStyle(
                            color: Colors.black54,
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                          )),
                          SizedBox(width: 6,),
                          Icon(Icons.edit_outlined, size: 15,),
                        ],
                      )
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: priceTagColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _showSuccess(context),
                    child: Text('Reserve', style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

