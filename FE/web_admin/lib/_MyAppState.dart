import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IPAddressChecker extends StatefulWidget {
  @override
  _IPAddressCheckerState createState() => _IPAddressCheckerState();
}

class _IPAddressCheckerState extends State<IPAddressChecker> {
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  String _result = '';

  Future<void> _checkConnection(String ipAddress, int port) async {
    try {
      final response = await http.get(Uri.parse('http://$ipAddress:$port'));
      if (response.statusCode == 200) {
        setState(() {
          _result = 'Connected to $ipAddress:$port';
        });
      } else {
        setState(() {
          _result = 'Failed to connect to $ipAddress:$port';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Failed to connect to $ipAddress:$port';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Connection Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _ipController,
              decoration: InputDecoration(
                labelText: 'Enter IP Address',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _portController,
              decoration: InputDecoration(
                labelText: 'Enter Port',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final ipAddress = _ipController.text.trim();
                final port = int.tryParse(_portController.text.trim()) ?? 80;
                if (ipAddress.isNotEmpty) {
                  _checkConnection(ipAddress, port);
                } else {
                  setState(() {
                    _result = 'Please enter an IP address';
                  });
                }
              },
              child: Text('Check Connection'),
            ),
            SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }
}
