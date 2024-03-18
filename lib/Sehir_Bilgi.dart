import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Sehir_Bilgi extends StatefulWidget {
  final String enteredCity;

  const Sehir_Bilgi({Key? key, required this.enteredCity}) : super(key: key);

  @override
  _Sehir_BilgiState createState() => _Sehir_BilgiState();
}

class _Sehir_BilgiState extends State<Sehir_Bilgi> {
  late String _cityInfo = '';
  late String _cityImage = '';

  @override
  void initState() {
    super.initState();
    _getCityInfo();
  }

  Future<void> _getCityInfo() async {
    final response = await http.get(Uri.parse(
        'https://tr.wikipedia.org/api/rest_v1/page/summary/${widget.enteredCity}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _cityInfo = data['extract'] ?? 'Bilgi bulunamadı.';
        _cityImage = data['originalimage']['source'] ?? ''; 
      });
    } else {
      setState(() {
        _cityInfo = 'Bilgi bulunamadı.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('${widget.enteredCity} Hakkında Bilgiler',
            style: const TextStyle(fontSize: 25)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _cityInfo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (_cityImage.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      _cityImage,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
