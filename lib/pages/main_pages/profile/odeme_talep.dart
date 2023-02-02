


import 'package:acikliyorum/api/post_buttons_api.dart';
import 'package:acikliyorum/pages/main_pages/main_pages.dart';
import 'package:acikliyorum/pages/main_pages/profile/profile_page.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OdemeTalep extends StatefulWidget {
  const OdemeTalep({Key? key}) : super(key: key);

  @override
  State<OdemeTalep> createState() => _OdemeTalepState();
}

class _OdemeTalepState extends State<OdemeTalep> {
  var isimKey = GlobalKey<FormFieldState>();
  var soyisimKey = GlobalKey<FormFieldState>();
  var tcKey = GlobalKey<FormFieldState>();
  var dogumyiliKey = GlobalKey<FormFieldState>();
  var telnoKey = GlobalKey<FormFieldState>();
  var ibanKey = GlobalKey<FormFieldState>();



  TextEditingController _isim = TextEditingController();
  TextEditingController _soyisim = TextEditingController();
  TextEditingController _tc = TextEditingController();
  TextEditingController _dogumYili = TextEditingController();
  TextEditingController _telNo = TextEditingController();
  TextEditingController _iban = TextEditingController();



  @override
  Widget build(BuildContext context) {

    String userid = ModalRoute.of(context)!.settings.arguments.toString();


    return Scaffold(
      appBar: acikliyorumAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
        ),
        child: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.all(5),
                    color: Colors.blue.shade200,
                    child: const ListTile(
                      leading: Icon(FontAwesomeIcons.circleInfo),
                      subtitle: Text("Bilgi - Minumum 35,0000 TL tutarında para çekim talebi verebilirsiniz."),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Alıcı TC Kimlik Numarası"),
                          border: OutlineInputBorder()),
                      obscureText: false,
                      key: tcKey,
                      controller: _tc,
                      keyboardType: TextInputType.number,
                      onSaved: (deger) {
                        _tc = deger as TextEditingController;
                      },
                      validator: (e){
                        if(e!.length<=10){
                          return "Geçerli bir TC Kimlik numarası giriniz";

                        }
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Alıcı Adı"),
                          border: OutlineInputBorder()),
                      obscureText: false,
                      key: isimKey,
                      controller: _isim,
                      onSaved: (deger) {
                        _isim = deger as TextEditingController;
                      },
                      validator: (e){
                        if(e!.length<=2){
                          return "Bu alan boş bırakılamaz";
                        }
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Alıcı Soyadı"),
                          border: OutlineInputBorder()),
                      obscureText: false,
                      key: soyisimKey,
                      controller: _soyisim,
                      onSaved: (deger) {
                        _soyisim = deger as TextEditingController;
                      },
                      validator: (e){
                        if(e!.length<=1){
                          return "Bu alan boş bırakılamaz";

                        }
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Alıcı Doğum Yılı"),
                          border: OutlineInputBorder()),
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      key: dogumyiliKey,
                      controller: _dogumYili,
                      onSaved: (deger) {
                        _dogumYili = deger as TextEditingController;
                      },
                      validator: (e){
                        if(e!.length<=3){
                          return "Geçerli bir yıl numarası giriniz";

                        }
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Alıcı Telefon Numarası"),
                          border: OutlineInputBorder()),
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      key: telnoKey,
                      controller: _telNo,
                      onSaved: (deger) {
                        _telNo = deger as TextEditingController;
                      },
                      validator: (e){
                        if(e!.length<=10){
                          return "Geçerli bir telefon numarası giriniz";

                        }
                      },
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text("IBAN"),
                          border: OutlineInputBorder()),
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      key: ibanKey,
                      controller: _iban,
                      onSaved: (deger) {
                        _iban = deger as TextEditingController;
                      },
                      validator: (e){
                        if(e!.length<=10){
                          return "Geçerli bir iban numarası giriniz";

                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () async{
                          if(tcKey.currentState!.validate()&& isimKey.currentState!.validate()&& soyisimKey.currentState!.validate()&& dogumyiliKey.currentState!.validate()&& telnoKey.currentState!.validate()&& ibanKey.currentState!.validate()
                          ){
                            await PostButtonsApi().odemeTalep(userid, _tc.text, _isim.text, _soyisim.text, _dogumYili.text, _telNo.text, _iban.text);
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('İşlem Başarılı'),
                                content: const Text('Para çekim talebiniz başarıyla alınmıştır'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: ()async {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPages(),));

                                    },
                                    child: const Text('Tamam'),
                                  ),
                                ],
                              ),
                            );

                          }
                    },
                        icon: const Icon(FontAwesomeIcons.check,color: Colors.white,), label: const Text("Ödeme talep et",style: TextStyle(color: Colors.white),)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
