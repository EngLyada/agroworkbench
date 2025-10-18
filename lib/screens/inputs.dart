import 'package:agroworkbench/Data/products.dart';
import 'package:agroworkbench/screens/homepage.dart';
import 'package:flutter/material.dart';

class AgroInputsScreen extends StatelessWidget {
  const AgroInputsScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Products',style:Theme.of(context).textTheme.titleMedium,
                ),
            ],
          ),
          //Featured products
          GridView.builder(
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
            itemCount:3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
              ), itemBuilder: (context, index) {
                return ProductCard(
                  product:product[index],
                  );
          },),
        ],
      ),
    );
  }
}
