import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> ongoingOrders = [
    {
      'products': ['Shisha Pipe', 'Mint Flavor', 'Charcoal'],
      'deliveryPerson': {'name': 'John Doe', 'phone': '+1234567890'},
      'estimatedTime': '5:30 PM',
    },
    {
      'products': ['Watermelon Flavor', 'Hose'],
      'deliveryPerson': {'name': 'Jane Smith', 'phone': '+0987654321'},
      'estimatedTime': '7:00 PM',
    },
    {
      'products': ['Grape Flavor', 'Foil'],
      'deliveryPerson': {'name': 'Ali Mohammed', 'phone': '+1122334455'},
      'estimatedTime': '6:15 PM',
    },
  ];

  void _showOrderDetailsDialog(
      BuildContext context, Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Products:'),
              for (var product in order['products'])
                Text(
                  '• $product',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 10),
              Text(
                'Delivery Person: ${order['deliveryPerson']['name']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Phone: ${order['deliveryPerson']['phone']}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Estimated Time: ${order['estimatedTime']}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Your Orders', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: ongoingOrders.length,
        itemBuilder: (context, index) {
          final order = ongoingOrders[index];
          return GestureDetector(
            onTap: () {
              _showOrderDetailsDialog(context, order);
            },
            child: Card(
              color: Colors.grey[900],
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                title: Text(
                  order['products'][0], // First product name
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                subtitle: Text(
                  'Delivery at: ${order['estimatedTime']}', // Estimated delivery time
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrdersPage(),
  ));
}
