import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:acikliyorum/api/post_buttons_api.dart';
import 'package:acikliyorum/api/single_user.dart';
import 'package:acikliyorum/models/single_user.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';


class AyarlarPage extends StatefulWidget {
  const AyarlarPage({Key? key}) : super(key: key);

  @override
  State<AyarlarPage> createState() => _AyarlarPageState();
}

class _AyarlarPageState extends State<AyarlarPage> {
  GlobalKey mailKey = GlobalKey();
  GlobalKey phoneKey = GlobalKey();
  GlobalKey passwordKey = GlobalKey();
  TextEditingController mail = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  String newCinsiyet="Erkek";


  File? image;
  final String? phpEndPoint = 'https://www.acikliyorum.com/api/insert/userProfileUpdate.php?id=11158';
  final String nodeEndPoint = 'http://192.168.43.171:3000/image';


  Future pickImage()async{
    try{
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery);
      if(image==null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
    } on PlatformException catch(e){
      print("fotoğraf alınamadı $e");
    }
  }

  Uri uri = Uri.parse("https://www.acikliyorum.com/api/insert/userProfileUpdate.php?id=11158");

  void _upload() {
    if (image == null) return;
    String base64Image = base64Encode(image!.readAsBytesSync());
    String fileName = image!.path.split("/").last;
    http.post(uri, body: {
      // "image": base64Image,
      "avatar": base64Image,
      "email": mail.text,
      "phone":phone.text,
      "gender":newCinsiyet,
      "password":password.text,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }


  void _denemeUploadFotili(filePath)async{

    try{
      FormData formData = FormData.fromMap({
        // "image": base64Image,
        "avatar": await MultipartFile.fromFile(filePath),
        "email": mail.text,
        "phone":phone.text,
        "gender":newCinsiyet,
        "password":password.text,
      });
      Response response = await Dio().post("https://www.acikliyorum.com/api/insert/userProfileUpdate.php?id=11158",data: formData);
      print("file upload response :$response");
    }catch(e){
      print("hata oluştu : $e");

    }


  }
  void _denemeUploadfotisiz()async{
    try{
      FormData formData = FormData.fromMap({
        // "avatar": await MultipartFile.fromFile(filePath),
        "email": mail.text,
        "phone":phone.text,
        "gender":newCinsiyet,
        "password":password.text,
      });
      Response response = await Dio().post("https://www.acikliyorum.com/api/insert/userProfileUpdate.php?id=11158",data: formData);
      print("file upload response :$response");
    }catch(e){
      print("hata oluştu : $e");

    }


  }

  _denemePost(){
    var response = http.post(uri, body: {
      // "image": base64Image,
      // "avatar": fileName,
      "email": mail.text,
      // "phone":phone.text,
      // "gender":newCinsiyet,
      // "password":password.text,
    });
    debugPrint(response.toString());

  }


  Response? response;
  String? progress;
  Dio dio = new Dio();
  uploadFile() async {
    String uploadurl = "https://www.acikliyorum.com/api/insert/userProfileUpdate.php?id=11158";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    FormData formdata = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(
          image!.path,
          filename: basename(image!.path)
        //show only filename from path
      ),
    });
    response = await dio.post(uploadurl,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent/total*100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" + " Bytes of " "$total Bytes - " +  percentage + " % uploaded";
          //update the progress
        });
      },);

    if(response!.statusCode == 200){
      print(response.toString());
      //print response from server
    }else{
      print("Error during connection to server.");
    }
  }

  @override
  Widget build(BuildContext context) {
    String userid = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: acikliyorumAppBar(),
      body: FutureBuilder<List<SingleUserModel>>(
        future: SingleUserApi.getUserData(userid),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = snapshot.data!;
            String userid = data[0].id.toString();
            String userName = data[0].username.toString();
            String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${data[0].avatar}";
            _ppControl(){
              if(data[0].avatar==null ||data[0].avatar==""){
                return data[0].gender=="Erkek"?
                const NetworkImage("https://www.acikliyorum.com/uploads/images/erkek.jpg"):
                const NetworkImage("https://www.acikliyorum.com/uploads/images/bayan.jpg");
              }
              else{
                return NetworkImage(userPhotoUrl);
              }
            }
            String? cinsiyet=data[0].gender;
            // newCinsiyet=cinsiyet!;


            return ListView(
              children: [
                InkWell(
                  onTap: ()async{
                    await pickImage();
                    setState(() {});

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   Container(
                     margin: const EdgeInsets.all(13),
                     height: 100,
                     width: 100,
                     decoration: BoxDecoration(
                         image: DecorationImage(image: image!=null?Image.file(image!,width: 200,height: 200,fit: BoxFit.cover,).image:_ppControl()),
                         shape: BoxShape.circle
                     ),
                   ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text("Kullanıcı adı"),
                  subtitle: TextFormField(
                    decoration: InputDecoration(
                      enabled: false,
                        label: Text(data[0].username.toString()),
                        border: OutlineInputBorder()),
                  ),
                ),
                ListTile(
                  title: Text("Email adresiniz"),
                  subtitle: TextFormField(
                    key: mailKey,
                    controller: mail,
                    decoration: InputDecoration(
                        label: Text(data[0].email.toString()),
                        border: OutlineInputBorder()),

                  ),
                ),
                ListTile(
                  title: Text("Telefon numaranız"),
                  subtitle: TextFormField(
                    key: phoneKey,
                    controller: phone,
                    decoration: InputDecoration(
                        label: Text(data[0].phone.toString()),
                        border: OutlineInputBorder()),
                  ),
                ),
                ListTile(
                  title: Text("Cinsiyet"),
                  subtitle: DropdownButton<String>(
                    hint: Text(newCinsiyet.toString()),
                    isExpanded: true,
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
                        newCinsiyet = s!;
                        print(newCinsiyet);
                      });
                    },
                    value: newCinsiyet,
                  ),
                ),
                ListTile(
                  title: Text("Şifreniz"),
                  subtitle: TextFormField(
                    key: passwordKey,
                    controller: password,
                    decoration: const InputDecoration(
                        label: Text("Değiştirmek istemiyorsanız boş bırakın"),
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if(image==null){
                          PostButtonsApi().updateUser( mail.text, newCinsiyet, phone.text, password.text, userid);
                        }else{
                          PostButtonsApi().updateUserWphoto(image!.path, mail.text, newCinsiyet, phone.text, password.text, userid);
                        }

                          // PostButtonsApi().updateUser(mail.text, newCinsiyet.toString(), phone.text, password.text, userid);
                          // PostButtonsApi().updateUserWphoto(image!.path, mail.text, newCinsiyet.toString(), phone.text, password.text, userid);
                      }
                      , child: Text("Güncelle",style: TextStyle(color: Colors.white),)),
                )

              ],
            );
          }else if(snapshot.hasError){
            return Center(child: Text("Birşeyler ters gitti"),);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }

        },
      ),
    );
  }


}
