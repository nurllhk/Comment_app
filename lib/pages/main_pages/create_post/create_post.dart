import 'package:acikliyorum/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:acikliyorum/api/product_api.dart';

import '../search/search_page.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  var searchKey = GlobalKey<FormFieldState>();
  TextEditingController search = TextEditingController();



  List<Step> getSteps() => [
        Step(
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 0,
          title: const Text(""),
          content: _step1(),
        ),
        Step(
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 1,
          title: Text(""),
          content: _step2(),
        ),
        Step(
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 2,
          title: Text(""),
          content: _step3(),
        ),
        Step(
          state: _currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 3,
          title: Text(""),
          content: _step4(),
        ),
        Step(
          state: _currentStep > 4 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 4,
          title: Text(""),
          content: _step5(),
        ),
        Step(
          state: _currentStep > 5 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 5,
          title: Text(""),
          content: _step6(),
        ),
        Step(
          state: _currentStep > 6 ? StepState.complete : StepState.indexed,
          isActive: _currentStep >= 6,
          title: Text(""),
          content: _step7(),
        ),
      ];

  int _currentStep = 0;
  bool isCompleted = false;
  bool tavsiye = true;
  int puan = 5;
  static const List<String> urunList = <String>[
    "Call of Duty Black Ops",
    "Volkswagen Golf 1.4 tsi",
    "Galaxy Book Pro",
    "Call of duty black ops 2",
  ];

  String urun = "";
  List<int> puanList = [5, 4, 3, 2, 1];







  @override
  Widget build(BuildContext context) {


    var searchKey = GlobalObjectKey(context);

    String? reviewid;
    String? tavsiye;
    String? incelemeBaslik;
    String? puan;
    String? fiyatPerformans;
    String? txt1;
    String? txt2;
    String? txt3;
    String? txt4;
    String? photo1;
    String? photo2;
    String? photo3;
    String? photo4;


    return isCompleted
        ? _buildCompleted()
        : Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/background.jpeg")
          )
      ),
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Stepper(
                steps: getSteps(),
                type: StepperType.horizontal,
                currentStep: _currentStep,
                onStepContinue: () {
                  setState(() {
                    if (_currentStep < 6) {
                      _currentStep++;
                      print(_currentStep);
                    } else {
                      isCompleted = true;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (_currentStep > 0) {
                      _currentStep--;
                    }
                  });
                },
                controlsBuilder: (BuildContext context, ControlsDetails details) {
                  return Row(children: <Widget>[
                    if (_currentStep != 0)
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
                    if (_currentStep != 0) const SizedBox(width: 14),
                    if (_currentStep != 6)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: const Text(
                            "Devam",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    if(_currentStep==6)Expanded(
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
              ),
            ),
        );
  }

  _buildCompleted() {
    debugPrint("Form tamamland??");
    return const Center(
      child: Text("Lorem ipsum"),
    );
  }

  _step1() {


    return Column(
      children: [
        const Text("??r??n/Hizmet ??ncelemesi olu??tur"
        ,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20,),
        TextFormField(
          onEditingComplete: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(),settings: RouteSettings(arguments: search.text)),);
          },
          key: searchKey,
          autofocus: false,
          decoration: const InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              hintText: "Aramak istedi??iniz ??r??n?? girin",
              prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
              label: Text("??r??n/Hizmet Ara"),
              border: OutlineInputBorder()),
          controller: search,
          onSaved: (e){
            search = e as TextEditingController;

          },
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  _step2() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
          "??ncelikle Tavsiye edip etmedi??ini belirle, k??sa bir ba??l??k ekle ve puanlaman?? yap."),
      Row(children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              tavsiye = true;
              setState(() {});
            },
            icon: const Icon(FontAwesomeIcons.solidThumbsUp),
            label: const Text("Evet"),
            style: ElevatedButton.styleFrom(
              primary: tavsiye == false ? Colors.white : Colors.green,
              onPrimary: tavsiye == false ? Colors.green : Colors.white,
              side: const BorderSide(color: Colors.green),
            ),
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              tavsiye = false;
              setState(() {});
            },
            icon: const Icon(FontAwesomeIcons.solidThumbsDown),
            label: const Text("Hay??r"),
            style: ElevatedButton.styleFrom(
              primary: tavsiye == true ? Colors.white : Colors.red,
              onPrimary: tavsiye == true ? Colors.red : Colors.white,
              side: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ]),
      const SizedBox(
        height: 8,
      ),
      TextFormField(
        decoration: const InputDecoration(
            hintText: "??nceleme Ba??l??????",
            label: Text("??nceleme Ba??l??????"),
            border: OutlineInputBorder()),
      ),
      const SizedBox(height: 8),
      DropdownButton<int>(
          hint: Text("Puan??n??z  "),
          icon: const Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.yellow,
          ),
          items: <int>[5, 4, 3, 2, 1].map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text("Puan: "+value.toString()),
            );
          }).toList(),
          onChanged: (e) {
            puan = e!;
          }),
      const Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    ]);
  }

  _step3() {
    return Column(
      children: [
        Text("Performans a????s??ndan fiyat??n?? hakediyor mu?"),
        Row(children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                tavsiye = true;
                setState(() {});
              },
              icon: const Icon(FontAwesomeIcons.solidThumbsUp),
              label: const Text("Evet"),
              style: ElevatedButton.styleFrom(
                primary: tavsiye == false ? Colors.white : Colors.green,
                onPrimary: tavsiye == false ? Colors.green : Colors.white,
                side: const BorderSide(color: Colors.green),
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                tavsiye = false;
                setState(() {});
              },
              icon: const Icon(FontAwesomeIcons.solidThumbsDown),
              label: const Text("Hay??r"),
              style: ElevatedButton.styleFrom(
                primary: tavsiye == true ? Colors.white : Colors.red,
                onPrimary: tavsiye == true ? Colors.red : Colors.white,
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ),
        ]),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  _step4() {
    return Column(
      children: [
        Text("??r??n/Hizmeti en az 75 kelime ile anlat??rm??s??n?"),
        const SizedBox(
          height: 14,
        ),
        TextFormField(
          maxLines: 10,
          decoration: const InputDecoration(
              hintText: "L??tfen t??m harfleri b??y??k yazmaktan ka????n??n??z.",
              border: OutlineInputBorder()),
          validator: (e){
            String cumle = e!;
            List<String>
            yeniCumle =cumle.split(" ");
            print(yeniCumle);

            if(yeniCumle.length<75){
              return "Metin en az 75 kelimeden olu??mal??d??r";
            }
          },
        ),
        const SizedBox(
          height: 5,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade200,
              onPrimary: Colors.black54,
            ),
            onPressed: () {

            },
            icon: Icon(FontAwesomeIcons.camera),
            label: Text("Dosya Ekle")),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  _step5() {
    return Column(
      children: [
        Text(
            "Bu ??r??n tecr??belerini en az 75 kelime ile tan??tmak istersen nas??l tan??t??rd??n?"),
        const SizedBox(
          height: 14,
        ),
        TextFormField(
          maxLines: 10,
          decoration: const InputDecoration(
              hintText: "L??tfen t??m harfleri b??y??k yazmaktan ka????n??n??z.",
              border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 5,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade200,
              onPrimary: Colors.black54,
            ),
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.camera),
            label: Text("Dosya Ekle")),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  _step6() {
    return Column(
      children: [
        Text(
            "deneyimlerini ve tecr??belerini l??tfen 1 foto??raf ve en az 75 kelime ile anlat??r m??s??n ?"),
        SizedBox(
          height: 14,
        ),
        TextFormField(
          maxLines: 10,
          decoration: InputDecoration(
              hintText: "L??tfen t??m harfleri b??y??k yazmaktan ka????n??n??z.",
              border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 5,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade200,
              onPrimary: Colors.black54,
            ),
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.camera),
            label: Text("Dosya Ekle")),
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  _step7() {
    return Column(
      children: [
        Text(
            "son olarak kullan??c??lara verece??in mesaj?? en az 75 kelime ile anlat??p ??r??ne ait son bir foto??raf ekler misin ?"),
        SizedBox(
          height: 14,
        ),
        TextFormField(
          maxLines: 10,
          decoration: InputDecoration(
              hintText: "L??tfen t??m harfleri b??y??k yazmaktan ka????n??n??z.",
              border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 5,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade200,
              onPrimary: Colors.black54,
            ),
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.camera),
            label: Text("Dosya Ekle")),
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
          color: Colors.grey,
        ),

      ],
    );
  }
}
