import 'package:flutter/material.dart';
import 'package:todolist/modeller/malzeme.dart';
import 'package:todolist/servisler/firestoreservisi.dart';

class MalzemeListesi extends StatefulWidget {
  const MalzemeListesi({Key? key}) : super(key: key);

  @override
  _MalzemeListesiState createState() => _MalzemeListesiState();
}

class _MalzemeListesiState extends State<MalzemeListesi> {
  TextEditingController textController = TextEditingController();
  List<Malzeme> malzemeler = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Malzeme Listesi"),
        ),
        body: FutureBuilder(
            future: FirestoreServisi().malzemeGetir(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Malzeme> malzemeler = snapshot.data as List<Malzeme>;
                return ListView.builder(
                    itemCount: malzemeler.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text(malzemeler[index].ad),
                        ));
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  malzemeEkle() {
    setState(() {
      malzemeler.add(textController.text as Malzeme);
      FirestoreServisi().malzemeEkle(textController.text as Malzeme);
    });
  }

  malzemeSil() {
    setState(() {
      malzemeler.remove(textController.text as Malzeme);
      FirestoreServisi().malzemeSil(textController.text as Malzeme);
    });
  }

  satirOlustur(List<Malzeme>? malzemeler) {
    malzemeler!.map((_malzeme) => satir(_malzeme));
  }

  satir(Malzeme _malzeme) {
    return ListTile(
      title: Text(_malzeme.ad),
    );
  }
}

/*
Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: malzemeler.length,
                itemBuilder: (context, index) => satirOlustur(malzemeler)),
          ),
          TextField(
            controller: textController,
          ),
          RaisedButton(onPressed: malzemeEkle(), child: Text("Ekle")),
          RaisedButton(onPressed: malzemeSil(), child: Text("Sil")),
        ],
      ),
*/