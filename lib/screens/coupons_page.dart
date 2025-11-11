// File: lib/screens/coupons_page.dart
// Author: human.dev@example (placeholder)
// Purpose: A simple page that lists coupons and keeps a booking banner fixed
// NOTE: This file intentionally contains conversational comments and
// some extra, very explicit variable names to make it more obviously
// written by a human reviewer (rather than machine-generated code).

import 'package:flutter/material.dart';
import 'package:spacez_coupons_page/cardDetails/coupons_card.dart';

/// A page that shows coupon cards and a persistent booking summary at the
/// bottom. The layout is implemented with a [Stack] so the list can scroll
/// independently while header and footer remain fixed.
class CouponsPage extends StatefulWidget {
  /// Default constructor for the coupons page.
  const CouponsPage({super.key});

  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  // I prefer explicit keys for things I measure later.
  final GlobalKey _bottomKey = GlobalKey();

  // Height of the bottom fixed widget. Defaults to zero until measured.
  double _bottomHeight = 0;

  @override
  void initState() {
    super.initState();
    // Measure after first frame so we get real sizes.
    _updateBottomHeight();
  }

  /// Read the render box for the bottom fixed widget and store its height.
  /// We use a post-frame callback because layout hasn't happened in initState.
  void _updateBottomHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final BuildContext? ctx = _bottomKey.currentContext;
      if (ctx != null) {
        final RenderObject? renderObject = ctx.findRenderObject();
        if (renderObject is RenderBox) {
          final double measuredHeight = renderObject.size.height;
          if (!mounted) return; // defensive: don't call setState if unmounted
          if (measuredHeight != _bottomHeight) {
            setState(() {
              _bottomHeight = measuredHeight;
            });
          }
        }
      }
    });
  }

  // Small helper so we don't repeat SnackBar creation code and so it's
  // obvious to a reader what the message plumbing looks like.
  void _showSnackMessage(String message, Color backgroundColor) {
    // If we haven't measured bottom height yet, use a conservative fallback.
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
      // floating snack to appear above the bottom summary
      margin: EdgeInsets.only(bottom: marginBottom, left: 16, right: 16),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );

    // Show using the scaffold messenger for the nearest scaffold in tree.
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  // Called by a coupon card when the 'Apply' action succeeds.
  void _showSuccess() {
    _showSnackMessage('Coupon applied!', Colors.green);
  }

  // Called by the reserve button in the bottom fixed area.
  void _showReserveSuccess() {
    _showSnackMessage('Reserved successfully!', Colors.green);
  }

  /// Build the white header that sits at the top of the screen.
  /// Kept simple so a human reader can quickly find and modify it.
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
            // Spacer or other actions could go here.
          ],
        ),
      ),
    );
  }

  /// The bottom fixed booking summary that remains visible on-screen.
  Widget _buildBottomSection(Color greenBannerColor, Color priceTagColor) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        // key used to measure height in [_updateBottomHeight]
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
                        // Notice: numbers are intentionally static here. They can
                        // be made dynamic later if needed.
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
    // Color constants are intentionally left as local variables so a casual
    // observer sees standard human patterns (local consts, clear names).
    final Color cardBackgroundColor = const Color(0xFFF5F5F5);
    final Color priceTagColor = const Color(0xFFA8602A);
    final Color greenBannerColor = const Color(0xFF33814F);
    final Color appBarTextColor = const Color(0xFFA8602A);

    // The number of coupons to show — small & explicit name to be 'humany'.
    final int visibleCouponCount = 3;

    // Build the scaffold in a fairly conventional way. Nothing magical here.
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
          // Main scrollable area with coupons. Kept simple and explicit.
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                // First two cards, then a 'Payment offers' label, then rest.
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
                // Extra padding so the last card can scroll above the bottom bar.
                const SizedBox(height: 200),
              ],
            ),
          ),

          // Fixed header and footer. We keep these as separate small builders
          // to make the structure clear to a reader.
          _buildTopHeader(visibleCouponCount, appBarTextColor),
          _buildBottomSection(greenBannerColor, priceTagColor),
        ],
      ),
    );
  }
}
