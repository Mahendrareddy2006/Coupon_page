import 'package:flutter/material.dart';
import 'package:spacez_coupons_page/cardDetails/coupons_card.dart';

class CouponsPage extends StatefulWidget {
  const CouponsPage({super.key});

  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  final GlobalKey _bottomKey = GlobalKey();
  double _bottomHeight = 0;

  @override
  void initState() {
    super.initState();
    _updateBottomHeight();
  }

  void _updateBottomHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final BuildContext? ctx = _bottomKey.currentContext;
      if (ctx != null) {
        final RenderObject? renderObject = ctx.findRenderObject();
        if (renderObject is RenderBox) {
          final double measuredHeight = renderObject.size.height;
          if (!mounted) return;
          if (measuredHeight != _bottomHeight) {
            setState(() {
              _bottomHeight = measuredHeight;
            });
          }
        }
      }
    });
  }

  void _showSnackMessage(String message, Color backgroundColor) {
    final double marginBottom = (_bottomHeight > 0)
        ? _bottomHeight + 8.0
        : 170.0;

    final SnackBar snack = SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.only(bottom: marginBottom, left: 16, right: 16),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void _showSuccess() {
    _showSnackMessage('Coupon applied!', Colors.green);
  }

  void _showReserveSuccess() {
    _showSnackMessage('Reserved successfully!', Colors.green);
  }

  Widget _buildTopHeader(int visibleCouponCount, Color appBarTextColor) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.arrow_back),
            const SizedBox(width: 20),
            Text(
              'Coupons ($visibleCouponCount)',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(Color greenBannerColor, Color priceTagColor) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        key: _bottomKey,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                Container(
                  color: greenBannerColor,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: const Text(
                    'Book now & Unlock exclusive rewards!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '₹19,500',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '₹16,000 for 2 nights',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '24 Apr - 26 Apr | 18 guests',
                          style: TextStyle(
                            color: Colors.black54,
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: priceTagColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _showReserveSuccess,
                      child: const Text(
                        'Reserve',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color cardBackgroundColor = const Color(0xFFF5F5F5);
    final Color priceTagColor = const Color(0xFFA8602A);
    final Color greenBannerColor = const Color(0xFF33814F);
    final Color appBarTextColor = const Color(0xFFA8602A);

    final int visibleCouponCount = 3;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.home, color: appBarTextColor),
            const SizedBox(width: 8),
            const Text(
              'SPACEZ',
              style: TextStyle(
                fontFamily: 'Cinzel',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [Icon(Icons.menu, color: appBarTextColor)],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                ...List.generate(
                  2,
                  (int index) => CouponCard(
                    priceTagColor: priceTagColor,
                    cardBgColor: cardBackgroundColor,
                    onApply: _showSuccess,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Payment offers:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ...List.generate(
                  visibleCouponCount - 2,
                  (int index) => CouponCard(
                    priceTagColor: priceTagColor,
                    cardBgColor: cardBackgroundColor,
                    onApply: _showSuccess,
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),

          _buildTopHeader(visibleCouponCount, appBarTextColor),
          _buildBottomSection(greenBannerColor, priceTagColor),
        ],
      ),
    );
  }
}
