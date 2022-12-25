//import 'package:dart_bbs/src/create_proof_value.dart';
import 'package:intl/intl.dart';
import 'package:nonce/nonce.dart';

import 'dart:convert';

String getDate() {
  DateTime now = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  String date = outputFormat.format(now);
  return date;
}

/* Format the proof for the VC */
String createProof(proofValue, veriMethod) {
  String proof = json.encode({
    "type": "BbsBlsSignatureProof2020",
    "created": getDate(),
    "verificationMethod": veriMethod, 
    "proofPurpose": "assertionMethod",
    "proofValue": proofValue,
  });
  return proof;
}
