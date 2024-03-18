import 'package:flutter/material.dart';

class Gidilen_Sehirler extends StatefulWidget {
  final List<String> gidilenSehirler; // Gidilen şehirlerin listesi

  const Gidilen_Sehirler({Key? key, required this.gidilenSehirler})
      : super(key: key);

  @override
  _Gidilen_SehirlerState createState() => _Gidilen_SehirlerState();
}

class _Gidilen_SehirlerState extends State<Gidilen_Sehirler> {
  List<String> _gidilenSehirler = []; 
  List<bool> _checkedList = []; 

  @override
  void initState() {
    super.initState();
    _gidilenSehirler =
        List.from(widget.gidilenSehirler); 
    _checkedList = List.filled(_gidilenSehirler.length,
        false); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Gidilen Şehirler',
            style: const TextStyle(fontSize: 25)),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Seçilen şehirleri listeden kaldır
              setState(() {
                _gidilenSehirler = _gidilenSehirler
                    .asMap()
                    .entries
                    .where((entry) => !_checkedList[entry.key])
                    .map((entry) => entry.value)
                    .toList();

                // Tüm checkbox'ları sıfırla
                _checkedList = List.filled(_gidilenSehirler.length, false);
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _gidilenSehirler.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.white.withOpacity(0.5), 
            margin: const EdgeInsets.symmetric(vertical: 4.0), 
            padding: const EdgeInsets.all(8.0), 
            child: ListTile(
              leading: Checkbox(
                value: _checkedList[index],
                onChanged: (newValue) {
                  setState(() {
                    _checkedList[index] = newValue!;
                  });
                },
              ),
              title: Text(_gidilenSehirler[index],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}
