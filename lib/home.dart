import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'cart_page.dart';  // ✅ Import cart page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFF2874F0),
          title: Row(
            children: [
              Image.asset('assets/flipkart_logo.png', height: 30),
              const SizedBox(width: 10),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: "Search for products",
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // ✅ Cart icon with navigation
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  );
                },
                child: const Icon(Icons.shopping_cart, color: Colors.white),
              ),
            ],
          ),
        ),
      ),

      // ✅ BODY stays SAME
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Banner Slider
            SizedBox(
              height: 150,
              child: PageView(
                children: [
                  bannerImage('assets/brand1.png'),
                  bannerImage('assets/brand2.png'),
                  bannerImage('assets/brand3.png'),
                ],
              ),
            ),

            // ✅ Categories Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  categoryItem("assets/grocery.png", "Grocery"),
                  categoryItem("assets/fashion.png", "Fashion"),
                  categoryItem("assets/beauty.png", "Beauty"),
                  categoryItem("assets/electronics.png", "Electronics"),
                ],
              ),
            ),

            // ✅ Still Looking For These?
            sectionTitle("Still looking for these?"),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  horizontalProduct("assets/shoe1.png", "Men's Shoes"),
                  horizontalProduct("assets/watch1.png", "Smart Watch"),
                  horizontalProduct("assets/earbuds.png", "Earbuds"),
                  horizontalProduct("assets/bag1.png", "Backpack"),
                ],
              ),
            ),

            // ✅ Sponsored
            sectionTitle("Sponsored"),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  horizontalProduct("assets/speaker1.png", "Bluetooth Speaker"),
                  horizontalProduct("assets/mouse1.png", "Wireless Mouse"),
                  horizontalProduct("assets/shirt1.png", "Men's Shirt"),
                  horizontalProduct("assets/band1.png", "Fitness Band"),
                ],
              ),
            ),

            // ✅ Suggested For You Grid
            sectionTitle("Suggested For You"),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                gridProduct("assets/shoe1.png", "Running Shoes", "₹899", context),
                gridProduct("assets/watch1.png", "Smart Watch", "₹1,999", context),
                gridProduct("assets/earbuds.png", "Earbuds Pro", "₹2,499", context),
                gridProduct("assets/bag1.png", "Laptop Bag", "₹999", context),
                gridProduct("assets/shirt1.png", "Casual Shirt", "₹799", context),
                gridProduct("assets/speaker1.png", "Mini Speaker", "₹599", context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bannerImage(String asset) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(asset, fit: BoxFit.cover),
    ),
  );

  Widget categoryItem(String asset, String title) {
    return Column(
      children: [
        CircleAvatar(radius: 25, backgroundImage: AssetImage(asset)),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget horizontalProduct(String asset, String title) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(asset, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  );

  Widget gridProduct(String asset, String title, String price, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ✅ SAFE navigation (all products work)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(
              image: asset,
              title: title,
              price: price,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(asset, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(price, style: const TextStyle(color: Colors.green)),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
