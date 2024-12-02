import 'package:flutter/material.dart';

class StockProductView extends StatelessWidget {
  const StockProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Product'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const Text(
              'Available Soybean Stock',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Placeholder for Stock Product List
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Just for demo, replace with dynamic data
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Soybean Product #${index + 1}'),
                      subtitle: Text('Stock: ${50 - index * 10} kg'), // Example stock
                      leading: Image.asset('assets/images/kedelai.png', width: 40, height: 40),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to product details or purchase page
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
