import 'package:flutter/material.dart';
import 'package:gezi_rehberim/GezilecekYer';
import 'package:gezi_rehberim/GidilenYer.dart';
import 'package:gezi_rehberim/Sehir_Bilgi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          const MyHomePage(title: 'Gezi Rehberim', color: Colors.indigoAccent),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.color});

  final String title;
  final MaterialAccentColor color;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _enteredCity;
  List<String> _gidilenSehirler = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title, style: const TextStyle(fontSize: 25)),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Colors.white.withOpacity(0.5), 
                  borderRadius:
                      BorderRadius.circular(10), 
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_balance),
                        hintText: 'Şehir',
                        labelText: 'Gitmek İstediğiniz Şehir İsmini Giriniz:',
                      ),
                      onSaved: (String? value) {},
                      validator: (String? value) {
                        return (value != null && value.contains('@'))
                            ? 'Do not use the @ char.'
                            : null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _enteredCity = value;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_enteredCity != null &&
                              _enteredCity!.isNotEmpty) {
                            setState(() {
                              _gidilenSehirler.add(_enteredCity!);
                            });
                            print('Girilen şehir: $_enteredCity');
                          } else {
                            print('Lütfen bir şehir ismi girin!');
                          }
                        },
                        child: const Text('Şehir Kaydet'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_enteredCity != null &&
                                  _enteredCity!.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Sehir_Bilgi(
                                          enteredCity: _enteredCity!)),
                                );
                              } else {
                                print('Lütfen bir şehir ismi girin!');
                              }
                            },
                            child: const Text('Şehir Hakkında Bilgiler'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_enteredCity != null &&
                                  _enteredCity!.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GezilecekYerSayfasi(
                                            cityName: _enteredCity!,
                                          )),
                                );
                              } else {
                                print('Lütfen bir şehir ismi girin!');
                              }
                            },
                            child: const Text('Şehre Dair Notlarım'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Gidilen_Sehirler(
                                        gidilenSehirler: _gidilenSehirler)),
                              );
                            },
                            child: const Text('Gidilen Şehirler'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Container(
                              width: 450,
                              height:
                                  230, 
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10), 
                                color: Colors.white.withOpacity(
                                    0.5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10), 
                                child: Image.asset(
                                  'images/travel_image.jpeg',
                                  fit: BoxFit
                                      .fill, 
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
