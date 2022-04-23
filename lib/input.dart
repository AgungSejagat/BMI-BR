import 'package:flutter/material.dart';
import 'package:flutter_bmi_2/model/bmi.dart';
import 'package:flutter_bmi_2/result.dart';
import 'package:flutter_bmi_2/rumus_BMI.dart';
import 'package:flutter_bmi_2/gender_card.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _State();
}

class _State extends State<InputPage> {
  double _currentSliderValue = 20;
  int _currentWeightValue = 30;
  String _currentGenderValue = "Laki-laki";
  Color maleColor = Colors.blueGrey;
  Color femaleColor = Colors.blueGrey;
  List<BMI> bmis = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //appBar kiri itu parameter, AppBar kanan itu class. Berlaku untuk bentuk lainnya yang serupa
        title: Text("Kalkulator BMI coy"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    child: (bmis.length < 1)
                        ? Center(
                            child:
                                Text("Belum ada perhitungan, yuk kita hitung"),
                          )
                        : ListView.builder(
                            itemCount: bmis.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(bmis[index].category),
                              subtitle: Text(
                                bmis[index].total.toString().substring(0, 6),
                              ),
                              leading: (bmis[index].gender == "Laki-laki")
                                  ? Icon(
                                      Icons.male,
                                      color: Colors.tealAccent,
                                    )
                                  : Icon(
                                      Icons.female,
                                      color: Colors.pink,
                                    ),
                            ),
                          ),
                  );
                },
              );
            },
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            _currentGenderValue = "Laki-laki";
                            setState(() {
                              maleColor = Colors.tealAccent;
                              femaleColor = Colors.blueGrey;
                            });
                          },
                          child:
                              GenderCard("Laki-laki", Icons.male, maleColor))),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _currentGenderValue = "Wanita";
                        setState(() {
                          maleColor = Colors.blueGrey;
                          femaleColor = Colors.pink;
                        });
                      },
                      child: GenderCard(
                        "Wanita",
                        Icons.female,
                        femaleColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.cyan, width: 8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tinggi Badan",
                      style: TextStyle(fontSize: 25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${_currentSliderValue.toInt()}",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(" cm"),
                      ],
                    ),
                    Slider(
                      value: _currentSliderValue,
                      min: 20,
                      max: 280,
                      divisions: 260,
                      label: _currentSliderValue.round().toString(),
                      activeColor: Colors.cyan.shade700,
                      inactiveColor: Colors.lightBlueAccent.shade100,
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan, width: 8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        if (_currentWeightValue < 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'terlalu kurus, jangan mirip raden coy'),
                            ),
                          );
                        } else {
                          _currentWeightValue--;
                          setState(() {});
                        }
                      },
                      child: Icon(
                        Icons.remove,
                        size: 30,
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        fixedSize: MaterialStateProperty.all(
                          Size.fromRadius(30),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Berat Badan",
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$_currentWeightValue",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(" Kg"),
                          ],
                        ),
                      ],
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _currentWeightValue++;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        fixedSize: MaterialStateProperty.all(
                          Size.fromRadius(30),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        child: TextButton(
          child: Text(
            "Kalkulasikan!",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            double total = RumusBMI.kalkulator_BMI(
                _currentSliderValue.toInt(), _currentWeightValue.toInt());
            BMI hasil = RumusBMI.kategori_BMI(_currentGenderValue, total);
            bmis.add(hasil);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Result(
                  bmi: hasil,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
