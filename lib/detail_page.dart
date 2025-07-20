import 'package:flutter/material.dart';
import 'cart_page.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String image;
  final String price;

  const DetailPage({
    super.key,
    required this.title,
    required this.image,
    required this.price,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String selectedSize = "8";

  @override
  Widget build(BuildContext context) {
    double discounted = double.parse(widget.price.replaceAll("₹", ""));
    double original = discounted + 800; // Example original price
    double discountPercent = ((original - discounted) / original) * 100;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.image, height: 220),
            const SizedBox(height: 12),

            Row(
              children: [
                Text("₹${discounted.toStringAsFixed(0)}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
                const SizedBox(width: 10),
                Text("₹${original.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    )),
                const SizedBox(width: 10),
                Text("${discountPercent.toStringAsFixed(0)}% OFF",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),

            const Text("Size - UK/India", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: ["6", "7", "8", "9", "10"]
                  .map((size) => ChoiceChip(
                label: Text(size),
                selected: selectedSize == size,
                onSelected: (_) => setState(() {
                  selectedSize = size;
                }),
              ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            const Text("Delivery",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text("Delivery by Tomorrow if ordered within 47m"),
            const Text("10 days return policy"),
            const Text("Cash on Delivery available"),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  cartItems.add({
                    "image": widget.image,
                    "title": widget.title,
                    "originalPrice": "₹${original.toStringAsFixed(0)}",
                    "discountedPrice": "₹${discounted.toStringAsFixed(0)}",
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to cart")),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white),
                child: const Text("Add to Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
