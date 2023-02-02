import 'package:acikliyorum/pages/styles/login_page_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FindPost extends StatefulWidget {
  const FindPost({Key? key}) : super(key: key);

  @override
  State<FindPost> createState() => _FindPostState();
}

class _FindPostState extends State<FindPost> {
  final String infoText = "Web sitemizde yarım milyondan daha fazla ürün bulunmaktadır, lütfen eklemeden önce kontrol edin";

  showAlertDialog(BuildContext context) {

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        setState((){});
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            child: ListTile(
              onTap: (){},
              tileColor: Colors.lightBlueAccent.shade100,
              leading: Icon(FontAwesomeIcons.circleInfo,color: Colors.black45,),
              title: Text(infoText,style: TextStyle(color: Colors.black54),),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,

            hintText: "Ürün/Hizmet Adı",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
        ),
        const Text("Aradığınız ürünü bulamadınızmı ? Bunu sitemize ekleyin"),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(


              style: ElevatedButton.styleFrom(
                primary: Colors.orange[700],

                minimumSize: Size(100, 40)
              ),

              onPressed: () {},
              icon: Icon(Icons.add,color: Colors.white),
              label: Text("Ekle",style: FontStyles.button,)),
        )
      ],
    );
  }
}

