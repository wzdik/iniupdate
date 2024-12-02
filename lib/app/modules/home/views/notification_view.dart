import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  // A list to store the selected notifications
  List<bool> _selectedNotifications = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifikasi Terkait Kedelai',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Daftar notifikasi
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Gantilah dengan jumlah notifikasi yang ada
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.shade200,
                        child: const Icon(Icons.notifications, color: Colors.green),
                      ),
                      title: Text(
                        'Notifikasi ${index + 1}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        'Diskon 20% untuk Produk Kedelai',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      trailing: Checkbox(
                        value: _selectedNotifications[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedNotifications[index] = value ?? false;
                          });
                        },
                      ),
                      onTap: () {
                        // Function to show detailed notification
                        _showNotificationDetail(context, index);
                      },
                    ),
                  );
                },
              ),
            ),
            if (_selectedNotifications.contains(true)) ...[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showSelectedNotifications();
                },
                child: const Text('Tampilkan Notifikasi Terpilih'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Function to show detailed notification
  void _showNotificationDetail(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Notifikasi ${index + 1}'),
          content: const Text('Diskon 20% untuk Produk Kedelai. Dapatkan produk berkualitas dengan harga lebih murah.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // Function to display selected notifications
  void _showSelectedNotifications() {
    List<int> selectedIndices = [];
    for (int i = 0; i < _selectedNotifications.length; i++) {
      if (_selectedNotifications[i]) {
        selectedIndices.add(i);
      }
    }
    
    String selectedText = selectedIndices.isNotEmpty
        ? 'Notifikasi Terpilih: ${selectedIndices.map((e) => 'Notifikasi ${e + 1}').join(', ')}'
        : 'Tidak ada notifikasi yang dipilih.';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notifikasi Terpilih'),
          content: Text(selectedText),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
