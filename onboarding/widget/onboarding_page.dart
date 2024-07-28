import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
@RoutePage()
class OnboardingPageScreen extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String buttonText;

  const OnboardingPageScreen({super.key, 
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
         
        ],
      ),
    );
  }
}
