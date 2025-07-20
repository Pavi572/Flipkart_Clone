import 'package:flutter/material.dart';

// Shared cart list
List<Map<String, String>> cartItems = [];

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("My Cart")),
        body: const Center(child: Text("Your cart is empty")),
      );
    }

    double totalOriginal = 0;
    double totalDiscounted = 0;

    for (var item in cartItems) {
      double original = double.parse(
          item["originalPrice"]!.replaceAll("₹", "").replaceAll(",", ""));
      double discounted = double.parse(
          item["discountedPrice"]!.replaceAll("₹", "").replaceAll(",", ""));
      totalOriginal += original;
      totalDiscounted += discounted;
    }

    double totalDiscount = totalOriginal - totalDiscounted;
    double couponDiscount = 100; // Fixed coupon for demo
    double platformFee = 4;
    double finalPayable =
        (totalDiscounted - couponDiscount) + platformFee;

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: Column(
        children: [
          // ✅ Cart item list
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];

                double original = double.parse(item["originalPrice"]!
                    .replaceAll("₹", "")
                    .replaceAll(",", ""));
                double discounted = double.parse(item["discountedPrice"]!
                    .replaceAll("₹", "")
                    .replaceAll(",", ""));
                double discountPercent =
                    ((original - discounted) / original) * 100;

                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: Image.asset(item["image"]!,
                        width: 60, height: 60, fit: BoxFit.cover),
                    title: Text(item["title"]!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "₹${discounted.toStringAsFixed(0)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "₹${original.toStringAsFixed(0)}",
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "${discountPercent.toStringAsFixed(0)}% OFF",
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text("Delivery by Tomorrow | Free Delivery"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          cartItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // ✅ Flipkart style price details
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Price Details",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price (${cartItems.length} items)"),
                    Text("₹${totalOriginal.toStringAsFixed(0)}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Discount"),
                    Text(
                      "-₹${totalDiscount.toStringAsFixed(0)}",
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Coupons for you"),
                    Text(
                      "-₹${couponDiscount.toStringAsFixed(0)}",
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Platform Fee"),
                    Text("₹${platformFee.toStringAsFixed(0)}"),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Amount",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(
                      "₹${finalPayable.toStringAsFixed(0)}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "You will save ₹${(totalDiscount + couponDiscount).toStringAsFixed(0)} on this order",
                  style: const TextStyle(color: Colors.green),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(14),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Order Placed Successfully!")),
                      );
                      setState(() {
                        cartItems.clear();
                      });
                    },
                    child: const Text("Place Order"),
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
