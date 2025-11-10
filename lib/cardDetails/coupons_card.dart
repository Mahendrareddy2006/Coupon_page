

import 'package:flutter/material.dart';

class CouponCard extends StatelessWidget {
  final Color priceTagColor;
  final Color cardBgColor;
  final VoidCallback onApply;
  const CouponCard({
    Key? key,
    required this.priceTagColor,
    required this.cardBgColor,
    required this.onApply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardBgColor,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 138,
            decoration: BoxDecoration(
              color: priceTagColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: -1,
              child: Text(
                '₹ 6,900',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'LONGSTAY',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: onApply,
                        child: Row(
                          children: [
                            Icon(Icons.check_circle_outline, size: 18, color: priceTagColor),
                            SizedBox(width: 4),
                            Text('Apply', style: TextStyle(color: priceTagColor)),
                          ],
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: priceTagColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    '15% off when you book for 5 days or more and 20% off when you book for 30 days or more.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Read more',
                    style: TextStyle(
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
