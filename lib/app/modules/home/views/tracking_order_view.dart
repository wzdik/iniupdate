import 'package:flutter/material.dart';

class TrackingOrderView extends StatelessWidget {
  const TrackingOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking Order'),
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
              'Your Orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Placeholder for Order Tracking List
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Just for demo, replace with dynamic data
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('Order #${index + 1}'),
                      subtitle: const Text('Status: In Progress'),
                      leading: const Icon(Icons.local_shipping), // Correct truck icon
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to detailed order view or tracking page
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
