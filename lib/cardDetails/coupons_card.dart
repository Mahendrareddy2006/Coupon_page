import 'package:flutter/material.dart';

class CouponCard extends StatefulWidget {
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
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  bool isApplied = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.cardBgColor,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 158,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: widget.priceTagColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  top: 22,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: widget.cardBgColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  top: 52,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: widget.cardBgColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  top: 82,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: widget.cardBgColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Center(
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      '₹ 6,900',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
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
                        onPressed: () {
                          setState(() {
                            isApplied = !isApplied;
                          });
                          if (isApplied) widget.onApply();
                        },
                        child: Row(
                          children: [
                            Icon(
                              isApplied
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              size: 18,
                              color: widget.priceTagColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              isApplied ? 'Applied' : 'Apply',
                              style: TextStyle(color: widget.priceTagColor),
                            ),
                          ],
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: widget.priceTagColor,
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
