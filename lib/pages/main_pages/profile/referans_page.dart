


import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferansPage extends StatefulWidget {
  String referer;
  String people;
  ReferansPage(this.referer,this.people);

  @override
  State<ReferansPage> createState() => _ReferansPageState();
}

bool pressed=false;
class _ReferansPageState extends State<ReferansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: acikliyorumAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: TextFormField(
                  enabled: false,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: widget.referer,
                    border: OutlineInputBorder()
                  ),

                ),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    Clipboard.setData(ClipboardData(text: widget.referer));
                    SnackBar(
                      content: const Text('Yay! A SnackBar!'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                  });

            }, icon: Icon(Icons.copy,color: Colors.white,), label: Text("Kopyala",style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }
}
