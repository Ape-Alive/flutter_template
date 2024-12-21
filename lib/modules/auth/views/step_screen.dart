import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StepScreen extends StatelessWidget {
  const StepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentIntroPage(),
    );
  }
}

class PaymentIntroPage extends StatefulWidget {
  const PaymentIntroPage({super.key});

  @override
  State<PaymentIntroPage> createState() => _PaymentIntroPageState();
}

class _PaymentIntroPageState extends State<PaymentIntroPage> {
  int currentPage = 0;
  final List<Map<String, String>> pages = [
    {
      'image': 'assets/cropped_image.png',
      'title': '更安全、更简单\n支付方式',
      'subtitle': '长达 10 天的买家保护，无需充值您的钱包\n免费退货运输和更快',
    },
    {
      'image': 'assets/cropped_image.png',
      'title': '购物无忧\n用PayPal',
      'subtitle': '长达 10 天的买家保护，无需充值您的钱包\n免费退货运输和更快',
    },
    {
      'image': 'assets/cropped_image.png',
      'title': '购物无忧\n更快捷支付',
      'subtitle': '通过 PayPal 体验更安全、更方便的支付方式',
    }
  ];

  void nextPage() {
    setState(() {
      if (currentPage < pages.length - 1) {
        currentPage++;
      }
      debugPrint('Current Page: \$currentPage'); // Debug current page index
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Building PaymentIntroPage with currentPage: \$currentPage'); // Debug build state
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top illustration
            Image.asset(
              pages[currentPage]['image']!,
              height: 220,
            ),

            const SizedBox(height: 30),

            // Title text
            Text(
              pages[currentPage]['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 15),

            // Subtitle text
            Text(
              pages[currentPage]['subtitle']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 30),

            // Indicator dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (index) {
                debugPrint(
                    'Rendering dot for page index: \$index'); // Debug dot rendering
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        index == currentPage ? Colors.blue : Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),

            const Spacer(),

            // Next button
            ElevatedButton(
              onPressed: () {
                debugPrint('Next button pressed'); // Debug button press
                nextPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Next Page',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Skip button
            TextButton(
              onPressed: () {
                debugPrint('Skip button pressed'); // Debug skip action
                // Handle skip
              },
              child: const Text(
                '跳过',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
