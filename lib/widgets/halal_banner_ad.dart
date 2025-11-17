import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Reusable Banner Ad Widget for Path of Light
/// Configured with G-rating filter for family-safe, Islamic-appropriate content
class HalalBannerAd extends StatefulWidget {
  const HalalBannerAd({super.key});

  @override
  State<HalalBannerAd> createState() => _HalalBannerAdState();
}

class _HalalBannerAdState extends State<HalalBannerAd> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  // Test Ad Unit ID - Replace with your real AdMob Ad Unit ID when ready
  // Android Test: ca-app-pub-3940256099942544/6300978111
  // iOS Test: ca-app-pub-3940256099942544/2934735716
  static const String _adUnitId = 'ca-app-pub-3940256099942544/6300978111';

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: _adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner Ad failed to load: $error');
          ad.dispose();
          setState(() {
            _isAdLoaded = false;
          });
        },
      ),
    );

    _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded || _bannerAd == null) {
      return const SizedBox.shrink(); // Empty widget if ad not loaded
    }

    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
