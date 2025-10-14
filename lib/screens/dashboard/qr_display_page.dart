import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRDisplayPage extends StatefulWidget {
  const QRDisplayPage({Key? key}) : super(key: key);

  @override
  _QRDisplayPageState createState() => _QRDisplayPageState();
}

class _QRDisplayPageState extends State<QRDisplayPage> {
  String qrData = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQRData();
  }

  Future<void> _loadQRData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // TODO: API INTEGRATION POINT
      // Replace this with actual API call to fetch dynamic QR code data
      // Example:
      // final response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));
      // final apiData = json.decode(response.body);
      // qrData = apiData['qr_url'] ?? 'default_url';

      // For now, using dummy data - replace with actual API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay

      // Dummy QR data - this should come from your API
      qrData =
          'https://fitness-app-saas.com/user/12345/profile?token=abc123&timestamp=${DateTime.now().millisecondsSinceEpoch}';

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Handle API error
      setState(() {
        isLoading = false;
        qrData = 'https://fitness-app-saas.com/error'; // Fallback URL
      });
    }
  }

  void _refreshQR() {
    _loadQRData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My QR Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.refresh),
        //     onPressed: _refreshQR,
        //     tooltip: 'Refresh QR Code',
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QR Code Display Area
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: isLoading
                  ? _buildLoadingState()
                  : qrData.isNotEmpty
                  ? _buildQRCode()
                  : _buildErrorState(),
            ),

            const SizedBox(height: 32),

            // Instructions
            Text(
              'Your Personal QR Code',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // Done Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                label: Text('Done'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(color: Colors.red),
        const SizedBox(height: 16),
        Text(
          'Generating QR Code...',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildQRCode() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // QR Code
        QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 250,
          gapless: false,
          errorStateBuilder: (context, error) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 8),
                Text(
                  'Error generating QR code',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 16),

        // QR Code Info
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Scan to access profile',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.qr_code, color: Colors.grey, size: 64),
        const SizedBox(height: 16),
        Text(
          'Unable to generate QR Code',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 8),
        Text(
          'Please try refreshing',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}
