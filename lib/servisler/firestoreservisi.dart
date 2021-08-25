import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist/modeller/malzeme.dart';

class FirestoreServisi {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  malzemeEkle(Malzeme malzeme) {
    _firestore.collection("Malzemeler").add({
      "malzemeId": malzeme.id,
      "malzemeAdi": malzeme.ad,
    });
  }

  Future<List<Malzeme>?> malzemeGetir() async {
    QuerySnapshot snapshot = await _firestore.collection("Malzemeler").get();
    List<Malzeme> malzemeler = snapshot.docs
        .map((malzeme) => Malzeme.dokumandanUret(malzeme))
        .toList();
    return malzemeler;
  }

  malzemeSil(Malzeme malzeme) async {
    QuerySnapshot snapshot = await _firestore
        .collection("Malzemeler")
        .where("malzemeAdi", isEqualTo: malzeme.ad)
        .get();
    snapshot.docs.forEach((DocumentSnapshot doc) {
      doc.reference.delete();
    });
  }
}
