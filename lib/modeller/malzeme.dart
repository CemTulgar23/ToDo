import 'package:cloud_firestore/cloud_firestore.dart';

class Malzeme {
  late String id;
  late String ad;

  Malzeme({
    required this.id,
    required this.ad,
  });

  factory Malzeme.dokumandanUret(DocumentSnapshot doc) {
    return Malzeme(id: doc.id, ad: doc.data()["malzemeAdi"]);
  }
}
