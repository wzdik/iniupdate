import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _storedName;
  String? _storedAddress;
  String? _storedPhone;
  String? _profileImagePath;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedName = prefs.getString('name');
      _storedAddress = prefs.getString('address');
      _storedPhone = prefs.getString('phone');
      _profileImagePath = prefs.getString('profileImage');
    });
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _nameController.text);
    prefs.setString('address', _addressController.text);
    prefs.setString('phone', _phoneController.text);
    prefs.setString('profileImage', _profileImagePath ?? '');

    _loadData();
    // Navigate to Profile Detail screen after saving
    Get.to(() => ProfileDetailView(
      name: _storedName,
      address: _storedAddress,
      phone: _storedPhone,
      profileImage: _profileImagePath,
    ));
  }

  _deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    prefs.remove('address');
    prefs.remove('phone');
    prefs.remove('profileImage');

    setState(() {
      _storedName = null;
      _storedAddress = null;
      _storedPhone = null;
      _profileImagePath = null;
    });
  }

  _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.green.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Center(
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: _profileImagePath != null
                      ? FileImage(File(_profileImagePath!))
                      : const NetworkImage('https://www.example.com/default-profile.png')
                          as ImageProvider,
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildProfileField('Nama', _nameController, _storedName),
            const SizedBox(height: 16),
            _buildProfileField('Alamat', _addressController, _storedAddress),
            const SizedBox(height: 16),
            _buildProfileField('Nomor Telepon', _phoneController, _storedPhone),
            const SizedBox(height: 20),

            AnimatedButton(
              onPressed: _saveData,
              color: Colors.green,
              label: 'Simpan Profil',
            ),
            const SizedBox(height: 20),
            if (_storedName != null && _storedAddress != null && _storedPhone != null) ...[
              const SizedBox(height: 20),
              const Text(
                'Profil Anda:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildProfileInfoText('Nama', _storedName),
              _buildProfileInfoText('Alamat', _storedAddress),
              _buildProfileInfoText('Nomor Telepon', _storedPhone),
              const SizedBox(height: 20),
              AnimatedButton(
                onPressed: _deleteData,
                color: Colors.red,
                label: 'Hapus Profil',
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller, String? initialValue) {
    controller.text = initialValue ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Masukkan $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfoText(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        '$label: $value',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String label;

  const AnimatedButton({required this.onPressed, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.white.withOpacity(0.3),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

// Profile Detail View after profile is saved
class ProfileDetailView extends StatefulWidget {
  final String? name;
  final String? address;
  final String? phone;
  final String? profileImage;

  const ProfileDetailView({this.name, this.address, this.phone, this.profileImage, super.key});

  @override
  _ProfileDetailViewState createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  bool _detailsVisible = false;

  void _toggleDetailsVisibility() {
    setState(() {
      _detailsVisible = !_detailsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profil'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 75,
              backgroundImage: widget.profileImage != null
                  ? FileImage(File(widget.profileImage!))
                  : const NetworkImage('https://www.example.com/default-profile.png')
                      as ImageProvider,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _toggleDetailsVisibility,
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
              child: Text(_detailsVisible ? 'Sembunyikan Detail' : 'Tampilkan Detail'),
            ),
            const SizedBox(height: 20),
            if (_detailsVisible) ...[
              Text('Nama: ${widget.name}', style: TextStyle(fontSize: 18)),
              Text('Alamat: ${widget.address}', style: TextStyle(fontSize: 18)),
              Text('Nomor Telepon: ${widget.phone}', style: TextStyle(fontSize: 18)),
            ],
          ],
        ),
      ),
    );
  }
}
