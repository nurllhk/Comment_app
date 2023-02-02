import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class NasilCalisir extends StatefulWidget {
  const NasilCalisir({Key? key}) : super(key: key);

  @override
  State<NasilCalisir> createState() => _NasilCalisirState();
}

class _NasilCalisirState extends State<NasilCalisir> {
  final String videoAdress = "assets/acikliyorum_video.mp4";
  late VideoPlayerController _controller;
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoAdress)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => _controller.play());
  }

  void disponse() {
    _controller.dispose();
    super.dispose();
  }

  final String _txt1 =
      "Açıklıyorum'da aklınıza gelebilecek her ürün için gerçek kullanıcı deneyimlerini ve incelemelerini bulabilirsiniz.";

  final String _txt2 =
      "Acikliyorum.com'da bilgi ve deneyimi paraya dönüştürebilirsiniz. Her gün onlarca ürün ve hizmet kullanıyorsunuz. Onlar hakkında faydalı yorumlar yazın ve düzenli gelir elde edin.";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          _controller.dispose();

          Navigator.pop(context, false);

          return Future.value(false);
        },
        child: Scaffold(
          appBar: acikliyorumAppBar(),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/background.jpeg"))),
            child: ListView(
              children: [
                Card(child: _video()),
                _headerTile("Yorumla Kazan", FontAwesomeIcons.coins),
                Card(
                  child: ListTile(
                    title: Text(
                      "Merhaba!",
                      style: _titleStyle(),
                    ),
                    subtitle: Text(
                      _txt1,
                      style: _subtitleStyle(),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Dürüst incelemelere ödeme yapıyoruz\n",
                        style: _titleStyle2()),
                    subtitle: Text(
                      _txt2,
                      style: _subtitleStyle(),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCard("Şimdi Üye Olun", FontAwesomeIcons.arrowRight),
                    _buildCard(
                        "İnceleme Yazın", FontAwesomeIcons.accessibleIcon),
                    _buildCard("Pasif Gelir Elde Edin", FontAwesomeIcons.vault)
                  ],
                ),
                _headerTile("Nasıl Kazanıyor,Nasıl Paylaşıyoruz?",
                    FontAwesomeIcons.question),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.newspaper,
                          color: Colors.orange[700],
                        ),
                        Text("Faydalı Bir İnceleme Yazıyorsun",style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                            "Bir ürün veya hizmet hakkında bilgi arayan kişiler"),
                        Text("tarafından okunur."),

                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.scroll,
                          color: Colors.orange[700],
                        ),
                        Text("İnceleme sayfasında reklam gösteriyoruz",style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                            "İnceleme nekadar iyi ve faydalı olursa"),
                        Text("o kadar çok görüntüleme alır"),

                      ],
                    ),
                  ),
                ),Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.scaleBalanced,
                          color: Colors.orange[700],
                        ),
                        Text("Reklan gelirini sizinle paylaşıyoruz",style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                            "İnceleme nekadar iyi ve faydalı olursa"),
                        Text("o kadar çok görüntüleme alır"),

                      ],
                    ),
                  ),
                ),
                _headerTile("Ödeme tablosu ve para çekimi işlemleri", Icons.graphic_eq),
                Card(
                  child: Image.asset("assets/odemetablo.PNG"),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.handshake,
                          color: Colors.orange[700],
                        ),
                        Text("Para çekimi",style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                            "Bakiyeniz 35 TL seviyesine ulaştığında dilediğiniz"),
                        Text("zaman para çekim talebi verebilirsiniz"),

                      ],
                    ),
                  ),
                ),
                _headerTile("Seviye gelişimi", Icons.signal_cellular_alt),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(FontAwesomeIcons.solidSquareCheck,color: Colors.green,),
                        title: Text("Onaylanan inceleme"),
                        subtitle: Text("Onaylanan her incelemeniz için puan alırsınız"),
                        trailing: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.all(5),

                          child: Text("5 puan",style: TextStyle(color: Colors.white),),),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(FontAwesomeIcons.droplet,color: Colors.green,),
                        title: Text("Ürüne ait ilk inceleme"),
                        subtitle: Text("İlgili ürüne ait ilk incelemeyi siz yaptıysanız puan alırsınız"),
                        trailing: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.all(5),

                          child: Text("6 puan",style: TextStyle(color: Colors.white),),),
                      ),
                    ],
                  ),
                ),Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(FontAwesomeIcons.textWidth,color: Colors.green,),
                        title: Text("Kelime oranı"),
                        subtitle: Text("İncelemenizde bulunan her 50 kelime için puan alırsınız."),
                        trailing: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.all(5),

                          child: Text("50 puan",style: TextStyle(color: Colors.white),),),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(FontAwesomeIcons.solidKeyboard,color: Colors.green,),
                        title: Text("İmla kuralları"),
                        subtitle: Text("İncelemenizde imla kurallarına dikkat etmeniz durumunda puan alırsınız. ( Örneğin; tüm harfleri büyük yazmamak, cümle başlangıçlarında büyük harf ile başlamak... )"),
                        trailing: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.all(5),

                          child: Text("8 puan",style: TextStyle(color: Colors.white),),),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(FontAwesomeIcons.image,color: Colors.green,),
                        title: Text("Eklenen fotoğraf"),
                        subtitle: Text("İncelemenize eklediğiniz fotoğraf başına puan alırsınız. ( Paragraf ve Fotoğraf yerleşiminde bulunan kurallar referans alınacaktır. )"),
                        trailing: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.all(5),

                          child: Text("10 puan",style: TextStyle(color: Colors.white),),),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(FontAwesomeIcons.camera,color: Colors.green,),
                        title: Text("Kaliteli fotoğraflar"),
                        subtitle: Text("İncelemenize eklediğiniz fotoğrafların kaliteli ve görüntü boyutu büyük olması durumunda puan alırsınız."),
                        trailing: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.all(5),

                          child: Text("15 puan",style: TextStyle(color: Colors.white),),),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(FontAwesomeIcons.cubes,color: Colors.green,),
                        title: Text("Parağraf ve fotoğraf yerleşimi"),
                        subtitle: Text("İncelemenizdeki paragraf ve fotoğrafların yerleşimine dikkat etmeniz durumunda puan alırsınız. ( Önerilen: Her 2 paragraf sonrasında fotoğraf yerleşimi )"),
                        trailing: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent,
                          ),
                          padding: EdgeInsets.all(5),

                          child: Text("20 puan",style: TextStyle(color: Colors.white),),),
                      ),
                    ],
                  ),
                ),
                _headerTile("Vakit geçir kazan", Icons.info_rounded),

                Card(
                  child: Column(
                    children: [
                      Text("\nAçıklıyorum'dan bir kazanç modeli daha!",style: TextStyle(fontWeight: FontWeight.w600),),
                      Text("Tüm kullanıcılarımızın sitemizde geçirdiği zamanı önemsiyor ve her geçen gün sitemizdeki aktiviteleri geliştiriyoruz. Artık kullanıcılarımız sadece yorum yazarak değil, sitede geçirdiği vakit üzerinden de para kazanabilecekler."),

                      Text("\nPeki nasıl çalışıyor",style: TextStyle(fontWeight: FontWeight.w600),),
                      Text("-Sitemizde geçirdiğiniz vakit başta da belirttiğimiz gibi bizim için oldukça değerli. Sitemize girişinizden itibaren, en az 10 saniye ilgili sayfa oturumunuzun açık kalması durumunda, her 10 saniye başına, bakiyenize 0,0001 TL yansıtılacaktır.\n-Bu işlem her kullanıcı, ip birleşimi için geçerli olup aynı IP'deki birden fazla kullanıcıyı kapsamamaktadır.\n-Bakiyenizdeki tutarı, sitemizde geçerli olan Minimum Para Çekimi dahilinde dilediğiniz zaman anında banka hesabınıza çekebilirsiniz."),

                      Text("\nGenel şartlar ve kurallar",style: TextStyle(fontWeight: FontWeight.w600),),
                      Text("-Bu kampanya sadece Türkiye için geçerlidir, diğer ülkelerdeki üyelerimizi kapsamamaktadır.\nSitemizdeki oturumunuzun ( sayfada kalma süresi ) minimum 10 saniye olmak zorundadır. Aksi halde bakiyenize ilgili ödül işlenmeyecektir.\n-Herhangi bir kullanıcının, ilgili sistemi kötüye kullanımı veya suistimal etmesi durumunda ilgili kullanıcıya ait üyelik kapatılacak ve bakiyesi silinecektir.\n-Acikliyorum.com, bu kampanya şartları ile ilgili her zaman düzenleme ve değiştirme hakkını saklı tutar."),

                    ],
                  ),
                ),





              ],
            ),
          ),
        ));
  }

  Card _headerTile(String baslik, IconData icon) {
    return Card(
      color: Colors.white,
      child: ListTile(
        tileColor: Colors.white,
        title: Text(baslik),
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.orange[700],
          ),
          height: 35,
          width: 35,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _buildCard(String title, IconData icon) {
    return Card(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Icon(
            icon,
            color: Colors.orange[700],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(title),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Container _video() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.orange, width: 3),
          borderRadius: BorderRadius.circular(0)),
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }

  TextStyle _titleStyle2() =>
      TextStyle(fontSize: 35, color: Colors.orange[700]);

  TextStyle _subtitleStyle() => const TextStyle(fontSize: 25);

  TextStyle _titleStyle() => TextStyle(fontSize: 50, color: Colors.orange[700]);
}
