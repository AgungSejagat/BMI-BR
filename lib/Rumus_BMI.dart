import 'dart:math';
import 'package:flutter_bmi_2/model/bmi.dart';

class RumusBMI {
  static List<String> message = [
    "Makan lebih ya,\n itu banyak takjilan di jalan yang murah",
    "Mantabs,\n lanjutkan dan tahankan yang anda lakukan",
    "Ciee bentar lagi masuk Obese,\n semangat ya ke sanannya atau lari dari sana",
    "Welcome to obesity,\n disarankan jangan lama-lama disini ya"
  ];

  static double kalkulator_BMI(int height, int weight) {
    double BMI = (weight / pow((height / 100), 2))
        .toDouble(); //100 dari konversi cm ke m
    return BMI;
  }

  static BMI kategori_BMI(String gender, double kalkulator_BMI) {
    BMI bmi = BMI(category: '', message: '', total: kalkulator_BMI, gender: gender);

    if (gender == "Laki-laki") {
      if (kalkulator_BMI < 18) {
        bmi.category = "Underweight";
        bmi.message = message[0];
      } else if (kalkulator_BMI < 25) {
        bmi.category = "Normal";
        bmi.message = message[1];
      } else if (kalkulator_BMI < 27) {
        bmi.category = "Overweight";
        bmi.message = message[2];
      } else {
        bmi.category = "Obese";
        bmi.message = message[3];
      }
    } else {
      if (kalkulator_BMI < 17) {
        bmi.category = "Underweight";
        bmi.message = message[0];
      } else if (kalkulator_BMI < 23) {
        bmi.category = "Normal";
        bmi.message = message[1];
      } else if (kalkulator_BMI < 27) {
        bmi.category = "Overweight";
        bmi.message = message[2];
      } else {
        bmi.category = "Obese";
        bmi.message = message[3];
      }
    }

    return bmi;
  }
}
