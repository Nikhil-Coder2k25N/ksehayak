import 'package:flutter/material.dart';
import 'package:ksehayak/Screens/drower.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ksehayak/URL/image.dart';

class StoreProduct {
  final String title;
  final String subtitle;
  final String price;
  final String rating;
  final String category;
  final String? imageUrl; // ✅ NULL SAFE
  final bool outOfStock;

  StoreProduct({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.category,
    required this.imageUrl,
    this.outOfStock = false,
  });
}

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

  String selectedCategory = "All Products";

  final List<String> categories = [
    "All Products",
    "Aeroponic Kits",
    "Sensors & Lights",
    "Irrigation"
  ];


  final List<StoreProduct> allProducts = [
    StoreProduct(
      title: "Complete Aeroponic Growing Kit",
      subtitle: "Complete setup for 50 sq ft area with misting system",
      price: "₹45,000",
      rating: "4.8",
      category: "Aeroponic Kits",
      imageUrl: AppImageModel.store1.Images,
    ),
    StoreProduct(
      title: "Smart IoT Sensor Bundle",
      subtitle: "Temperature, humidity, light & soil moisture sensors",
      price: "₹12,000",
      rating: "4.9",
      category: "Sensors & Lights",
      imageUrl: AppImageModel.store2.Images, // 👉 different image
    ),
    StoreProduct(
      title: "LED Grow Lights (Full Spectrum)",
      subtitle: "High-efficiency 300W full spectrum LED panel",
      price: "₹8,500",
      rating: "4.7",
      category: "Sensors & Lights",
      imageUrl: AppImageModel.store3.Images,
    ),
    StoreProduct(
      title: "Irrigation Controller System",
      subtitle: "Automated drip irrigation with smart scheduling",
      price: "₹15,000",
      rating: "4.6",
      category: "Irrigation",
      imageUrl: AppImageModel.store4.Images,
    ),
    StoreProduct(
      title: "Climate Control Unit",
      subtitle: "Integrated heating, cooling & humidity control",
      price: "₹22,000",
      rating: "4.8",
      category: "Irrigation",
      outOfStock: true,
      imageUrl: AppImageModel.store5.Images,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Colors.green, width: 1)),
        backgroundColor: Colors.white,
        title: Text(
          "Kisan Sehayak",
          style: GoogleFonts.quicksand(
              fontSize: 23, fontWeight: FontWeight.bold, color: Colors.deepOrange),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network(
                  AppImageModel.appLogo.Images,
                  height: 35,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: const ProfileDrawerUI(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE + CART
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    "Machinery &\nSupplies Store",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                  label: const Text("Cart (0)"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),
            const Text(
              "Everything you need for smart saffron farming",
              style: TextStyle(color: Colors.black26),
            ),

            const SizedBox(height: 18),

            /// CATEGORY CHIPS
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: selectedCategory == cat,
                      onSelected: (_) => setState(() => selectedCategory = cat),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            /// PRODUCTS FILTERED
            ...allProducts
                .where((p) => selectedCategory == "All Products" || p.category == selectedCategory)
                .map((product) => ProductCard(
              title: product.title,
              subtitle: product.subtitle,
              price: product.price,
              rating: product.rating,
              outOfStock: product.outOfStock,
              imageUrl: product.imageUrl, // ✅ PASSING
            ))
                .toList(),


            const SizedBox(height: 24),

            /// SUBSCRIPTION SECTION CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.sync),
                      SizedBox(width: 8),
                      Text("Maintenance Subscription Plans",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Regular maintenance and support for your equipment",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 18),
                  SubscriptionCard(
                    tag: "Basic",
                    price: "₹3,000/month",
                    features: const [
                      "Quarterly equipment checks",
                      "Phone support",
                      "Software updates"
                    ],
                  ),
                  SubscriptionCard(
                    tag: "Popular",
                    price: "₹6,000/month",
                    highlight: true,
                    features: const [
                      "Monthly equipment checks",
                      "Priority phone support",
                      "Software updates",
                      "20% discount on parts",
                      "Emergency repairs included"
                    ],
                  ),
                  SubscriptionCard(
                    tag: "Premium",
                    price: "₹10,000/month",
                    features: const [
                      "Bi-weekly equipment checks",
                      "24/7 dedicated support",
                      "Software updates & upgrades",
                      "30% discount on parts",
                      "Emergency repairs included",
                      "Expert consultation"
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SubscriptionCard extends StatelessWidget {
  final String tag, price;
  final List<String> features;
  final bool highlight;

  const SubscriptionCard({
    super.key,
    required this.tag,
    required this.price,
    required this.features,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlight ? Colors.purple : Colors.grey.shade300,
          width: highlight ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TAG LABEL
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: highlight ? Colors.purple : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tag,
              style: TextStyle(
                color: highlight ? Colors.white : Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(price,
              style:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

          const SizedBox(height: 6),

          Text(
            highlight
                ? "Complete peace of mind"
                : "Essential maintenance coverage",
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 12),

          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                const Icon(Icons.check, size: 16),
                const SizedBox(width: 8),
                Expanded(child: Text(f)),
              ],
            ),
          )),

          const SizedBox(height: 14),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: highlight ? Colors.purple : Colors.white,
              foregroundColor: highlight ? Colors.white : Colors.black,
              elevation: 0,
              side: BorderSide(
                  color: highlight ? Colors.purple : Colors.grey.shade300),
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Subscribe"),
          )
        ],
      ),
    );
  }
}
class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String title, subtitle, price, rating;
  final bool outOfStock;

  const ProductCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.outOfStock = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 NETWORK IMAGE WITH FALLBACK
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imageUrl ?? "https://via.placeholder.com/400x300.png?text=No+Image",
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  height: 170,
                  color: Colors.grey.shade200,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 170,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, size: 40),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(rating),
                    const SizedBox(width: 10),
                    Text(price,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: outOfStock ? null : () {},
                  icon: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white),
                  label: Text(
                    outOfStock ? "Out of Stock" : "Add to Cart",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    outOfStock ? Colors.grey.shade300 : Colors.black,
                    minimumSize: const Size(double.infinity, 44),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
