import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:incheck/orders.dart';
import 'update.dart';
import 'package:incheck/productpage.dart'; // Import the Product List Page

class ShishaLandingPage extends StatelessWidget {
  final List<Map<String, String>> carouselItems = [
    {"image": "images/incheck.jpg", "label": "Featured Flavors"},
    {"image": "images/incheck2.jpg", "label": "Best Sellers"},
    {"image": "images/incheck3.jpg", "label": "New Arrivals"},
    {"image": "images/incheck4.jpg", "label": "Seasonal Favorites"},
  ];

  final List<Map<String, String>> categories = [
    {'name': 'Flavors', 'image': "images/incheck.jpg"},
    {'name': 'Accessories', 'image': "images/incheck4.jpg"},
    {'name': 'Bundles', 'image': "images/incheck5.jpg"},
    {'name': 'Offers', 'image': "images/incheck.jpg"},
  ];

  void _navigateToCategory(BuildContext context, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductListPage(category: categoryName),
      ),
    );
  }

  void _navigateToCarouselItem(BuildContext context, String itemName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductListPage(
            category: itemName), // Pass category name to ProductListPage
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for the landing page
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            hintText: 'Search shisha flavors, accessories...',
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Promotional Banner Carousel with Labels
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
                viewportFraction: 0.85,
              ),
              items: carouselItems.map((carouselItem) {
                return GestureDetector(
                  onTap: () {
                    _navigateToCarouselItem(context, carouselItem['label']!);
                  },
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: AssetImage(carouselItem['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Label overlay
                      Positioned(
                        bottom: 10,
                        left: 20,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            carouselItem['label']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Categories Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToCategory(context, category['name']!);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      width: 100,
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                image: AssetImage(category['image']!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            category['name']!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            // Navigation to Product List Page
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onPressed: () {
                  // Navigate to Product List Page without a specific category
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'View Products',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white70,
        currentIndex: 0, // Home is initially selected
        onTap: (index) {
          if (index == 1) {
            // Navigate to the orders page
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UploadProductPage()), // Implement this page
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Orders'),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ShishaLandingPage(),
  ));
}
