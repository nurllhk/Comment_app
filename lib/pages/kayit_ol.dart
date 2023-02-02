import 'package:acikliyorum/FutureFunc.dart';
import 'package:acikliyorum/pages/uye_girisi.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:acikliyorum/pages/main_pages/main_pages.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';



import '../FutureFunc.dart';
class KayitOl extends StatefulWidget {
  @override
  _KayitOlState createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  int _aktifStep = 0;
  String isim = '', mail = '', sifre = '',telefon = '',cinsiyet = 'Erkek',iban = '';
  List<Step> tumStepler = [];


  late final Future<String> register;



  bool hata = false;

  var usernameKey = GlobalKey<FormFieldState>();
  var mailKey = GlobalKey<FormFieldState>();
  var passwordKey = GlobalKey<FormFieldState>();
  var telKey = GlobalKey<FormFieldState>();
  var cinsiyetKey = GlobalKey<FormFieldState>();
  var ibanKey = GlobalKey<FormFieldState>();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referance = TextEditingController();
  TextEditingController phone = TextEditingController();




  @override
  void initState() {
    super.initState();
  }

  bool sozlesme=false;

  @override
  Widget build(BuildContext context) {
    tumStepler = _tumStepler();

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Image(
              image: AssetImage("assets/logo.png"),
              alignment: Alignment.centerLeft,
              height: 40,
            )),
        body: Container(
          margin: EdgeInsets.only(top: 3),
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          child: SingleChildScrollView(
            child: Stepper(
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Row(children: <Widget>[
                  if (_aktifStep != 0)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade400),
                        onPressed: details.onStepCancel,
                        child: const Text(
                          "Geri",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  if (_aktifStep != 0) const SizedBox(width: 14),
                  if (_aktifStep != 6)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        child: const Text(
                          "Devam",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  if(_aktifStep==6)Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text(
                        "Bitir",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )

                ]);
              },
              steps: _tumStepler(),
              currentStep: _aktifStep,
              // onStepTapped: (deger){
              //   setState((){
              //     _aktifStep = deger;
              //   });
              // },

              onStepContinue: (){
                setState((){
                  _ileriButonuKontrolu();
                });

              },
              onStepCancel: (){
                setState((){
                  if(_aktifStep>0){
                    _aktifStep --;

                  }
                  else{
                    _aktifStep =0;

                  }
                });

              },
            ),
          ),
        ),
      ),
    );
  }

  List<Step> _tumStepler() {
    List<Step> stepler = [
      Step(
        title: const Text("Kullanıcı Adı"),
        state: _stateleriAyarla(0),
        isActive: true,
        content: TextFormField(
          onEditingComplete: (){
            setState(() {
              _ileriButonuKontrolu();
            });
          },
          controller: username,
          maxLength: 14,
          key: usernameKey,
          decoration: const InputDecoration(
              hintText: "Kullanıcı Adı",
              border: OutlineInputBorder()),
          validator: (girilenDeger) {
            if (girilenDeger!.length < 6) {
              return "Kullanıcı adı 6 ile 14 karakter arasında olmalıdır";
            }
          },
          onChanged: (e){
            isim = e;
          },
        ),
      ),
      Step(
        title: const Text("Email"),
        state: _stateleriAyarla(1),
        isActive: true,
        content: TextFormField(
          onEditingComplete: (){
            setState(() {
              _ileriButonuKontrolu();
            });
          },
          controller: email,
          keyboardType: TextInputType.emailAddress,
          key: mailKey,
          decoration: const InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder()),
          validator: (girilenDeger) {
            if (girilenDeger!.length < 6 || !girilenDeger.contains("@")) {
              return "Geçerli bir mail adresi giriniz";
            }
          },
          onChanged: (e){
            mail = e;
          },
        ),
      ),
      Step(
        title: Text("Telefon"),
        state: _stateleriAyarla(2),
        isActive: true,
        content: TextFormField(
          onEditingComplete: (){
            setState(() {
              _ileriButonuKontrolu();
            });
          },
          controller: phone,
          maxLength: 11,
          keyboardType: TextInputType.phone,
          key: telKey,
          decoration: const InputDecoration(
              hintText: "Telefon",
              border: OutlineInputBorder()),
          validator: (value){
            if (value!.length < 10){
              return "Geçerli bir telefon numarası giriniz";
            }
          },
          onChanged: (e){
            telefon = e;
          },
        ),
      ),

      Step(
        title: const Text("Cinsiyet"),
        state: _stateleriAyarla(3),
        isActive: true,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DropdownButton<String>(
              items: <String>['Erkek','Kadın']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      value == "Erkek" ?
                      const Icon(FontAwesomeIcons.mars,color: Colors.blue,)
                          :const Icon(FontAwesomeIcons.venus,color: Colors.pink,),
                      const SizedBox(width: 8,),
                      Text(value),
                    ],),


                );
              }).toList(),
              onChanged: (s){
                setState(() {
                  cinsiyet = s!;
                  print(cinsiyet);
                });
              },
              value: cinsiyet,
            ),
          ],
        ),
      ),

      Step(
        title: Text("Şifre"),
        state: _stateleriAyarla(4),
        isActive: true,
        content: TextFormField(
          onEditingComplete: (){
            setState(() {
              _ileriButonuKontrolu();
            });
          },
          controller: password,
          key: passwordKey,
          decoration: const InputDecoration(
              hintText: "Şifre",
              border: OutlineInputBorder()),
          validator: (girilenDeger) {
            if (girilenDeger!.length < 6) {
              return "Şifre En az 6 karakter olmalı";
            }
          },
          onChanged: (e){
            sifre = e;
          },
        ),
      ),
      Step(
        title: Text("İban"),
        state: _stateleriAyarla(5),
        isActive: true,
        content: Column(
          children: [
            TextFormField(
              onEditingComplete: (){
                setState(() {
                  _ileriButonuKontrolu();
                });
              },
              controller: referance,
              key: ibanKey,
              decoration: const InputDecoration(
                  hintText: "İban",
                  border: OutlineInputBorder()),
              validator: (girilenDeger) {
                if (girilenDeger!.length < 6) {
                  return "Yoksa boş bırakınız...";
                }
              },
              onSaved: (girilenDeger) {
                iban = girilenDeger ?? '';
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "Varsa Referans kodu",
                  helperMaxLines: 3,
                  // helperText: "Üye olduğunuz taktirde, Açıklıyorum kullanım sözleşmesi ve Gizlilik Sözleşmesini kabul etmiş sayılırsınız.",
                  border: OutlineInputBorder()),
              validator: (girilenDeger) {
                if (girilenDeger!.length < 6) {
                  return "Yoksa boş bırakınız...";
                }
              },
              onSaved: (girilenDeger) {
                iban = girilenDeger ?? '';
              },
            ),
            Row(
              children: [
                Checkbox(

                  value: sozlesme,
                  onChanged: (value) {
                    sozlesme=value!;
                    debugPrint(sozlesme.toString());
                    setState(() {

                    });

                },),
                Flexible(child: Text("Açıklıyorum kullanım sözleşmesi ve Gizlilik Sözleşmesini kabul ediyorum"))
              ],
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),


    ];

    return stepler;
  }

  StepState _stateleriAyarla(int oankiStep) {
    if (_aktifStep == oankiStep) {
      if (hata) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else
      return StepState.complete;
  }

  void _ileriButonuKontrolu() {
    switch (_aktifStep) {
      case 0:
        if (usernameKey.currentState!.validate()) {
          usernameKey.currentState!.save();
          hata = false;
          _aktifStep = 1;
        } else {
          hata = true;
        }
        break;

      case 1:
        if (mailKey.currentState!.validate()) {
          mailKey.currentState!.save();
          hata = false;
          _aktifStep = 2;
        } else {
          hata = true;
        }
        break;
      case 2:
        if (telKey.currentState!.validate()) {
          telKey.currentState!.save();
          hata = false;
          _aktifStep = 3;
        } else {
          hata = true;
        }
        break;
      case 3:
        _aktifStep = 4;

        break;

      case 4:
        if (passwordKey.currentState!.validate()) {
          passwordKey.currentState!.save();
          hata = false;
          _aktifStep = 5;
        } else {
          hata = true;
        }
        break;
      case 5:
        ibanKey.currentState!.save();
        hata = false;
        formTamamlandi();

        break;
    }
  }
  formTamamlandi()async{
    if(sozlesme==true){
      try{
        var result = await Dio().post('https://www.acikliyorum.com/api/json/register.php?username=$isim&email=$mail&pass=$sifre&phn=$telefon&gender=$cinsiyet&bank=$iban');
        debugPrint("kayit basarili");
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text("Kayıt işleminiz gerçekleşti artık giriş yapabilirsiniz"),
            actions: [
              TextButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UyeGiris(),));


              }, child: Text("Giriş yap"))
            ],
          );
        },);
        return result.toString();
      }

      on DioError catch(e) {
        debugPrint(Future.error(e.message).toString());
        return e.message.toString();
      }
    }else{
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text("Açıklıyorum kullanıcı sözleşmesini kabul etmeden kayıt olamazsınız"),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Tamam"))
          ],
        );
      },);

    }



  }
}
