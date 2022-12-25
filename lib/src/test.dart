import 'package:dart_bbs/dart_bbs.dart';
import 'package:dart_bbs/src/create_proof_value.dart';
import 'package:dart_bbs/src/create_proof.dart';
import 'package:nonce/nonce.dart';

import 'package:intl/intl.dart';
import 'dart:convert';


/* Function for the date */
String getDate() {
  DateTime now = DateTime.now();
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  String date = outputFormat.format(now);
  return date;
}

/* Main function */
void main() async {
  
  /* Set publicKey and secretKey */
  String pk = "plAUct6Jg1DYHw3Q8H91LICj6X0heemlzy6glNGwTejIaXq3B5SGUOkWZ8bYTFgJBAhUbf9s56erXYX3IFjAKsJh8gl1zdEIVMpERPLEMEWwBUS5MoCE/oAKn/rSH5zQ";
  String sk = "G2d4K5LCdHoLijHkhQ+E2fjqJuDdUz0YWp/QPVgymOk=";

  /* Set messages (components) of a VC to be issued */
  String message0 = json.encode({
    "context": [
      "https://www.w3.org/2018/credentials/v1",
      "https://www.w3.org/2018/credentials/examples/v1"
    ],
    "id": "http://localhost:9000/vc/1",
    "type": ["VerifiableCredential"],
    "issuer": "did:issuer:0001",
    "issuanceDate": getDate()
  }); 
  String message1 = json.encode({"id": "did:holder:0001"});
  String message2 = json.encode({"type": "Name", "subject": "Michael Ding"});
  String message3 =
      json.encode({"type": "BirthDate", "subject": "January 1st, 1991"});
  String message4 =
      json.encode({"type": "Institute", "subject": "The University of Tokyo"});

  List<String> messages = [
    message0,
    message1,
    message2,
    message3,
    message4
  ];

  /* Obtain the proofValue for the given inputs */
  String proofValue = await createProofValue( pk, sk, messages );
  print(proofValue);

  /* Format the proof */
  String veriMethod = "did:issuer:0001";
  String proof = createProof(proofValue, veriMethod);
  print(proof);

  /* Format the VC */
  Map VC = {...json.decode(messages[0]), ...json.decode(messages[1])};
  VC["id"] = "did:holder:0001";
  VC["claim"] = "{name:Michael Ding}, {BirthDate:January 1st 1991}, {Institute:The University of Tokyo}";
  VC["proof"] = proof;
  print(VC);

}
