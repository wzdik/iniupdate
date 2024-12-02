import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // A list to track the selection of products in the cart
  List<bool> _selectedProducts = List.generate(5, (index) => false);

  // A list of product prices
  List<int> _productPrices = [50000, 50000, 50000, 50000, 50000]; // Replace with actual prices

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Keranjang Belanja',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Daftar produk kedelai
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Gantilah dengan jumlah produk yang ada
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
                        child: const Icon(Icons.shopping_cart, color: Colors.green),
                      ),
                      title: Text(
                        'Produk Kedelai ${index + 1}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Harga: Rp ${_productPrices[index]}',
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      trailing: Checkbox(
                        value: _selectedProducts[index],
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedProducts[index] = value ?? false;
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _selectedProducts[index] = !_selectedProducts[index];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Checkout button
            ElevatedButton(
              onPressed: _getSelectedProducts().isNotEmpty
                  ? () {
                      // Navigate to the payment page with selected products
                      _navigateToPaymentPage(context);
                    }
                  : null, // Disable button if no product is selected
              child: const Text('Checkout'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to get the selected products and calculate total price
  List<int> _getSelectedProducts() {
    List<int> selectedProducts = [];
    for (int i = 0; i < _selectedProducts.length; i++) {
      if (_selectedProducts[i]) {
        selectedProducts.add(i);
      }
    }
    return selectedProducts;
  }

  // Function to navigate to the payment page
  void _navigateToPaymentPage(BuildContext context) {
    List<int> selectedProducts = _getSelectedProducts();
    int totalAmount = selectedProducts.fold(0, (sum, index) => sum + _productPrices[index]);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          selectedProducts: selectedProducts,
          totalAmount: totalAmount,
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  final List<int> selectedProducts;
  final int totalAmount;

  const PaymentPage({
    required this.selectedProducts,
    required this.totalAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rincian Pembayaran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Produk yang dipilih:'),
            const SizedBox(height: 10),
            ...selectedProducts.map((index) {
              return Text('Produk Kedelai ${index + 1}');
            }).toList(),
            const SizedBox(height: 20),
            Text('Total: Rp $totalAmount', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text(
              'Pilih Metode Pembayaran:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Payment method buttons
            Column(
              children: [
                _buildPaymentButton(context, 'BNI', '1234567890'),
                _buildPaymentButton(context, 'BCA', '0987654321'),
                _buildPaymentButton(context, 'BRI', '1122334455'),
                _buildPaymentButton(context, 'Mandiri', '6677889900'),
                _buildPaymentButton(context, 'QRIS', 'SCAN-QRIS-123'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create payment buttons
  Widget _buildPaymentButton(BuildContext context, String bankName, String paymentCode) {
    return ElevatedButton(
      onPressed: () {
        _showPaymentInstructions(context, bankName, paymentCode);
      },
      child: Text(bankName),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  // Function to show payment instructions
  void _showPaymentInstructions(BuildContext context, String bankName, String paymentCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Metode Pembayaran: $bankName'),
          content: Text(
            'Silakan lakukan pembayaran sebesar Rp $totalAmount menggunakan metode $bankName.\n\n'
            'Kode Pembayaran Anda: $paymentCode\n\n'
            'Ikuti langkah berikut:\n'
            '1. Masuk ke aplikasi atau ATM $bankName.\n'
            '2. Pilih menu "Transfer" atau "Pembayaran".\n'
            '3. Masukkan kode pembayaran.\n'
            '4. Konfirmasi pembayaran sebesar Rp $totalAmount.\n'
            '5. Selesai. Terima kasih telah berbelanja!',
          ),
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
