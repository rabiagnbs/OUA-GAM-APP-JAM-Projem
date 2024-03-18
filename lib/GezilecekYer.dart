import 'package:flutter/material.dart';

class GezilecekYerSayfasi extends StatefulWidget {
  final String cityName;

  GezilecekYerSayfasi({required this.cityName});

  @override
  _GezilecekYerSayfasiState createState() => _GezilecekYerSayfasiState();
}

class _GezilecekYerSayfasiState extends State<GezilecekYerSayfasi> {
  List<String> turistikYerler = [];
  List<String> yedigiYemekler = [];
  List<String> notlar = [];

  final TextEditingController turistikYerlerController = TextEditingController();
  final TextEditingController yedigiYemeklerController = TextEditingController();
  final TextEditingController notlarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('${widget.cityName} Notlarım..'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildList(turistikYerler, turistikYerlerController, 'Turistik Yerler'),
              SizedBox(height: 16.0),
              _buildList(yedigiYemekler, yedigiYemeklerController, 'Yediğiniz Yemekler'),
              SizedBox(height: 16.0),
              _buildList(notlar, notlarController, 'Notlar'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                
                },
                child: Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<String> items, TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(items[index]),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () {
                      
                    },
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Yeni madde ekle',
          ),
          onFieldSubmitted: (value) {
            setState(() {
              items.add(value);
              controller.clear();
            });
          },
        ),
      ],
    );
  }
}
