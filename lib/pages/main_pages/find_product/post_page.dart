import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'find_post.dart';
import 'new_post.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final String infoText =
      "Web sitemizde yarım milyondan daha fazla ürün bulunmaktadır, lütfen eklemeden önce kontrol edin";

  List<String> items = [];

  String category ="Anne&Bebek";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: acikliyorumAppBar(),
        body: ListView(
          children: [
            Card(
              child: ListTile(
                onTap: () {},
                tileColor: Colors.lightBlueAccent.shade100,
                leading: Icon(
                  FontAwesomeIcons.circleInfo,
                  color: Colors.black45,
                ),
                title: Text(
                  infoText,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
            ListTile(
              title: Text("Kategori"),
              subtitle: DropdownButton(
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text("deneme"));
                }).toList(),
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: Text("Marka"),
              subtitle: Card(
                child: TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ),
            ListTile(
              title: Text("Ürün başlığı"),
              subtitle: Card(
                child: TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ),
          ],
        ));
  }
}
