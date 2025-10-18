import 'package:agroworkbench/screens/login_screen.dart';

import '../utils/app_textstyles.dart';
import '../controllers/app_push.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Genuine & Quality Inputs',
      description: 'Access only certified, high-quality agricultural products.',
      image: 'assets/illustrations/Product_quality-bro.png',
    ),
    OnboardingItem(
      title: 'AI-Powered Insights',
      description:
          'Get smart crop recommendations tailored to your soil, location, and climate — powered by real-time AI analysis.',
      image: 'assets/illustrations/bot.png',
    ),
    OnboardingItem(
      title: 'Market Intelligence',
      description:
          'Stay ahead with up-to-date market data — price forecasts, demand trends, and buyer insights to help you sell better.',
      image: 'assets/illustrations/market_intelligence.png',
    ),
    OnboardingItem(
      title: 'Credit Access',
      description:
          'Unlock financing faster with AI-based credit scoring — empowering farmers and agribusinesses with fair, data-driven access to loans.',
      image: 'assets/illustrations/assesment.png',
    ),
  ];

  //get started button
  void _getstarted() {
    final Auth authController = Get.find<Auth>();
    authController.setFirstTimeDone();
    Get.off(() => LoginScreen());

  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_items[index].image.endsWith('.svg'))
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        '',
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    )
                  else
                    Image.asset(
                      _items[index].image,
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                  const SizedBox(height: 40),
                  Text(
                    _items[index].title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.withColor(
                      AppTextStyles.h1,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      _items[index].description,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodylarge,
                        isDark ? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Indicator Dots
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: _currentPage == index ? 24.0 : 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300]!,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => _getstarted(),
                  child: Text(
                    'Skip',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodymedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _items.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                    else {
                      // Navigate to main app or home screen
                      _getstarted();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentPage == _items.length - 1 ? 'Get Started' : 'Next',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodymedium,
                      Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}
