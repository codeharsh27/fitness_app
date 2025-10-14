import 'package:flutter/material.dart';
import 'dart:async';

class PromotionalBanners extends StatefulWidget {
  const PromotionalBanners({Key? key}) : super(key: key);

  @override
  _PromotionalBannersState createState() => _PromotionalBannersState();
}

class _PromotionalBannersState extends State<PromotionalBanners> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _banners = [
    {
      'title': 'BRINAILTY PREMIUM',
      'subtitle': 'Elite Collection',
      'description':
          'Discover premium fitness essentials crafted for champions',
      'color': Colors.green,
      'icon': Icons.diamond,
    },
    {
      'title': 'BRINAILTY PREMIUM',
      'subtitle': 'Performance Series',
      'description':
          'Advanced supplements designed for peak athletic performance',
      'color': Colors.orange,
      'icon': Icons.flash_on,
    },
    {
      'title': 'BRINAILTY PREMIUM',
      'subtitle': 'Recovery Formula',
      'description': 'Scientifically formulated for optimal muscle recovery',
      'color': Colors.blue,
      'icon': Icons.healing,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Start auto-scroll timer
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: PageView.builder(
        controller: _pageController,
        itemCount: _banners.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          return _buildBannerCard(_banners[index]);
        },
      ),
    );
  }

  Widget _buildBannerCard(Map<String, dynamic> banner) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Left side - Icon and text
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(banner['icon'], color: banner['color'], size: 32),
                  const SizedBox(height: 8),
                  Text(
                    banner['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    banner['subtitle'],
                    style: TextStyle(
                      color: banner['color'],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    banner['description'],
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Right side - CTA Button
            Container(
              margin: const EdgeInsets.only(left: 12),
              child: ElevatedButton(
                onPressed: () {
                  // Handle banner tap
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Offer: ${banner['title']}'),
                      backgroundColor: banner['color'],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: banner['color'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  'Shop Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
