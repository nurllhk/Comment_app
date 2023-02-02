import 'dart:io';
import 'package:acikliyorum/models/products_model.dart';
import 'package:acikliyorum/utils/database_helper.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:acikliyorum/api/product_api.dart';
import 'package:image_picker/image_picker.dart';
import '../search/search_page.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class CreatePostTester extends StatefulWidget {
  String productid;
  String productName;
  String categoryid;
  String bid;
  CreatePostTester(this.productid,this.productName,this.categoryid,this.bid);

  @override
  State<CreatePostTester> createState() => _CreatePostTesterState();
}

class _CreatePostTesterState extends State<CreatePostTester> {
  var searchKey = GlobalKey<FormFieldState>();
  TextEditingController baslikController = TextEditingController();

  var baslikKey = GlobalKey<FormFieldState>();
  var txt1Key = GlobalKey<FormFieldState>();
  var txt2Key = GlobalKey<FormFieldState>();
  var txt3Key = GlobalKey<FormFieldState>();
  var txt4Key = GlobalKey<FormFieldState>();



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

  List<int> puanList = [5, 4, 3, 2, 1];

  File? image1;
  File? image2;
  File? image3;
  File? image4;

  String? productreviewid;
  String? producttavsiye;
  String? productincelemeBaslik;
  String? productpuan="5";
  String? productfiyatPerformans;
  String? producttxt1;
  String? producttxt2;
  String? producttxt3;
  String? producttxt4;

  String? productphoto1;
  String? productphoto2;
  String? productphoto3;
  String? productphoto4;

  String? postContent;



  void postReview(userid)async{
    try{
      FormData formData = FormData.fromMap({
        "u_id": userid ,
        "b_id": widget.bid,
        "c_id":widget.categoryid,
        "price_rate":productfiyatPerformans,
        "recommend":producttavsiye,
        "title": productincelemeBaslik,
        "rate":productpuan,
        "img":await MultipartFile.fromFile(image1!.path),
        "rev":producttxt1,
        "img1":await MultipartFile.fromFile(image2!.path),
        "rev1":producttxt2,
        "img2":await MultipartFile.fromFile(image3!.path),
        "rev2":producttxt3,
        "img3":await MultipartFile.fromFile(image4!.path),
        "rev3":producttxt4,
      });
      Response response = await Dio().post("https://www.acikliyorum.com/api/insert/reviewsInsert.php?p_id=${widget.productid}",data: formData);
      print("file upload response :$response");
    }catch(e){
      print("hata oluştu : $e");

    }


  }

  Future pickImage1()async{
    try{
      final image1 = await ImagePicker().pickImage(
          source: ImageSource.gallery);
      if(image1==null) return;
      final imageTemporary = File(image1.path);
      this.image1 = imageTemporary;
    } on PlatformException catch(e){
      print("fotoğraf alınamadı $e");
    }
  }

  Future pickImage2()async{
    try{
      final image2 = await ImagePicker().pickImage(
          source: ImageSource.gallery);
      if(image2==null) return;
      final imageTemporary = File(image2.path);
      this.image2 = imageTemporary;
    } on PlatformException catch(e){
      print("fotoğraf alınamadı $e");
    }
  }
  Future pickImage3()async{
    try{
      final image3 = await ImagePicker().pickImage(
          source: ImageSource.gallery);
      if(image3==null) return;
      final imageTemporary = File(image3.path);
      this.image3 = imageTemporary;
    } on PlatformException catch(e){
      print("fotoğraf alınamadı $e");
    }
  }
  Future pickImage4()async{
    try{
      final image4 = await ImagePicker().pickImage(
          source: ImageSource.gallery);
      if(image4==null) return;
      final imageTemporary = File(image4.path);
      this.image4 = imageTemporary;
    } on PlatformException catch(e){
      print("fotoğraf alınamadı $e");
    }
  }


  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {

    productreviewid = widget.productid;


    return Scaffold(
      appBar: acikliyorumAppBar(),
      body: FutureBuilder(
        future: dbHelper.kullaniciSorgu("1"),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var myid = snapshot.data!;
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
                    setState(() => _ileriButonuKontrolu());
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
                          onPressed: (){
                            debugPrint("form bitti");
                            postReview(myid);
                            showDialog(context: context, builder: (context) => AlertDialog(
                              title: Text("İşlem başarılı"),
                              content: Text("İncelemeniz en kısa zamanda kontrol edilip paylaşılacaktır"),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }, child: Text("Kapat"))
                              ],
                            ),);
                          },
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
          else if (snapshot.hasError){
            return const Center(child: Text("İnceleme oluşturmak için önce giriş yapmalısınız"));
          }
          else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      )




    );



  }

  _buildCompleted() {
    debugPrint("Form tamamlandı");
    return const Center(
      child: Text("Lorem ipsum"),
    );
  }

  _step1() {


    return Column(
      children: [
        const Text("Ürün/Hizmet İncelemesi oluştur"
          ,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20,),
        TextFormField(
          maxLines: 1,
          enabled: false,
          key: searchKey,
          autofocus: false,
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 17),
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              hintText: "Aramak istediğiniz ürünü girin",
              prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
              label: Text(widget.productName,overflow: TextOverflow.ellipsis),
              border: OutlineInputBorder()),

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
          "Öncelikle Tavsiye edip etmediğini belirle, kısa bir başlık ekle ve puanlamanı yap."),
      Row(children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              tavsiye = true;
              producttavsiye = "1";
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
              producttavsiye="0";
              setState(() {});
            },
            icon: const Icon(FontAwesomeIcons.solidThumbsDown),
            label: const Text("Hayır"),
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
        key: baslikKey,
        controller: baslikController,
        decoration: const InputDecoration(
            hintText: "İnceleme Başlığı",
            label: Text("İnceleme Başlığı"),
            border: OutlineInputBorder()),
        onChanged: (e){
          productincelemeBaslik = e;
        },
        validator: (e){
          if(e!.length <= 3){
            return "Bu alan boş bırakılamaz";
          }
        },
      ),
      const SizedBox(height: 8),
      DropdownButton<String>(
          hint: Text("$productpuan Puan"),
          icon: const Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.yellow,
          ),
          items: <String>["5", "4", "3", "2", "1"].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text("Puan: "+value),
            );
          }).toList(),
          onChanged: (e) {
            setState((){
              productpuan = e!;
              print(productpuan);
            });

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
        Text("Performans açısından fiyatını hakediyor mu?"),
        Row(children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                tavsiye = true;
                producttavsiye = "1";
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
                producttavsiye = "0";
                setState(() {});
              },
              icon: const Icon(FontAwesomeIcons.solidThumbsDown),
              label: const Text("Hayır"),
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
        Text("Ürün/Hizmeti en az 75 kelime ile anlatırmısın?"),
        const SizedBox(
          height: 14,
        ),
        TextFormField(
          key: txt1Key,
          maxLines: 10,
          decoration: const InputDecoration(
              hintText: "Lütfen tüm harfleri büyük yazmaktan kaçınınız.",
              border: OutlineInputBorder()),
          onChanged: (e){
            producttxt1=e;
          },
          validator: (e){
            String cumle = e!;
            List<String>
            yeniCumle =cumle.split(" ");
            print(yeniCumle);

            if(yeniCumle.length<75){
              return "Metin en az 75 kelimeden oluşmalıdır \nMevcut kelime sayısı : ${yeniCumle.length}";
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
            onPressed: () async{
              await pickImage1();
              setState(() {});
            },
            icon: image1==null?
            Icon(FontAwesomeIcons.camera):
            Icon(FontAwesomeIcons.check,color: Colors.green,),
            label: Text(
            image1==null?
                "Dosya Ekle":
                "Dosya Yüklendi"
            )),
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
            "Bu ürün tecrübelerini en az 75 kelime ile tanıtmak istersen nasıl tanıtırdın?"),
        const SizedBox(
          height: 14,
        ),
        TextFormField(
          key: txt2Key,
          maxLines: 10,
          decoration: const InputDecoration(
              hintText: "Lütfen tüm harfleri büyük yazmaktan kaçınınız.",
              border: OutlineInputBorder()),
          onChanged: (e){
            producttxt2=e;
          },
          validator: (e){
            String cumle = e!;
            List<String>
            yeniCumle =cumle.split(" ");
            print(yeniCumle);

            if(yeniCumle.length<75){
              return "Metin en az 75 kelimeden oluşmalıdır mavcut uzunluk=${yeniCumle.length}";
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
            onPressed: () async{
              await pickImage2();
              setState(() {});
            },
            icon: image2==null?
            Icon(FontAwesomeIcons.camera):
            Icon(FontAwesomeIcons.check,color: Colors.green,),
            label: Text(
                image2==null?
                "Dosya Ekle":
                "Dosya Yüklendi"
            )),
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
            "deneyimlerini ve tecrübelerini lütfen 1 fotoğraf ve en az 75 kelime ile anlatır mısın ?"),
        SizedBox(
          height: 14,
        ),
        TextFormField(
          key: txt3Key,
          maxLines: 10,
          decoration: InputDecoration(
              hintText: "Lütfen tüm harfleri büyük yazmaktan kaçınınız.",
              border: OutlineInputBorder()),
          onChanged: (e){
            producttxt3=e;
          },
          validator: (e){
            String cumle = e!;
            List<String>
            yeniCumle =cumle.split(" ");
            print(yeniCumle);

            if(yeniCumle.length<75){
              return "Metin en az 75 kelimeden oluşmalıdır mavcut uzunluk=${yeniCumle.length}";
            }
          },
        ),
        SizedBox(
          height: 5,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade200,
              onPrimary: Colors.black54,
            ),
            onPressed: () async{
              await pickImage3();
              setState(() {});
            },
            icon: image3==null?
            Icon(FontAwesomeIcons.camera):
            Icon(FontAwesomeIcons.check,color: Colors.green,),
            label: Text(
                image3==null?
                "Dosya Ekle":
                "Dosya Yüklendi"
            )),
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
            "son olarak kullanıcılara vereceğin mesajı en az 75 kelime ile anlatıp ürüne ait son bir fotoğraf ekler misin ?"),
        SizedBox(
          height: 14,
        ),
        TextFormField(
          key: txt4Key,
          maxLines: 10,
          decoration: InputDecoration(
              hintText: "Lütfen tüm harfleri büyük yazmaktan kaçınınız.",
              border: OutlineInputBorder()),
          onChanged: (e){
            producttxt4 = e;
          },
          validator: (e){
            String cumle = e!;
            List<String>
            yeniCumle =cumle.split(" ");
            print(yeniCumle);

            if(yeniCumle.length<75){
              return "Metin en az 75 kelimeden oluşmalıdır mavcut uzunluk=${yeniCumle.length}";
            }
          },
        ),
        SizedBox(
          height: 5,
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade200,
              onPrimary: Colors.black54,
            ),
            onPressed: () async{
              await pickImage4();
              setState(() {});
            },
            icon: image4==null?
            Icon(FontAwesomeIcons.camera):
            Icon(FontAwesomeIcons.check,color: Colors.green,),
            label: Text(
                image4==null?
                "Dosya Ekle":
                "Dosya Yüklendi"
            )),
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
  void _ileriButonuKontrolu() {
    switch (_currentStep) {
      case 0:
        _currentStep = 1;
        break;

      case 1:
        if (baslikKey.currentState!.validate()) {
          baslikKey.currentState!.save();
          _currentStep = 2;
        }
        break;
      case 2:
        _currentStep = 3;
        break;
      case 3:
        if (txt1Key.currentState!.validate()) {
          txt1Key.currentState!.save();
          _currentStep = 4;
        }
        break;
      case 4:
        if (txt2Key.currentState!.validate()) {
          txt2Key.currentState!.save();
          _currentStep = 5;
        }
        break;
      case 5:
        if (txt3Key.currentState!.validate()) {
          txt3Key.currentState!.save();
          _currentStep = 6;
        }
        break;
    }
  }
}
