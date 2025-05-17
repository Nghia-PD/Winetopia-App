import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:winetopia_app/services/firebase_auth.dart';
import 'package:winetopia_app/services/firebase_firestore.dart';
import 'package:winetopia_app/shares/setting.dart';

class NfcContainer extends StatefulWidget {
  const NfcContainer({super.key});

  @override
  State<NfcContainer> createState() => _NfcContainerState();
}

class _NfcContainerState extends State<NfcContainer> {
  String _nfcData = "Tap and scan NFC chip to buy wine";

  void _startNFC() async {
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        // Try to parse the tag as an NDEF tag
        final ndef = Ndef.from(tag);

        if (ndef == null) {
          print('Tag is not NDEF formatted');
          NfcManager.instance.stopSession();
          return;
        }

        await ndef.read().then((NdefMessage message) {
          for (var record in message.records) {
            if (record.typeNameFormat == NdefTypeNameFormat.nfcWellknown) {
              final payload = record.payload;

              // Skip first byte (language code length byte)
              final text = String.fromCharCodes(payload.sublist(3)).toString();
              setState(() {
                _nfcData = text;
              });
              String uid = AuthService().currentUser!.uid;
              FirestoreService(uid: uid).updateBalance(_nfcData);
            }
          }
        });

        NfcManager.instance.stopSession();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 250,
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: Setting().borderLineColor, width: 2.0),
        // borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // center vertically
        crossAxisAlignment: CrossAxisAlignment.center, // center horizontally
        children: [
          ElevatedButton(
            onPressed: () {
              _startNFC();
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(40), // controls the size of the circle
              backgroundColor: Setting().buttonColor, // button color
            ),
            child: Icon(
              Icons.touch_app,
              size: 32,
              color: Setting().otherComponentColorLight,
            ), // or Text("Scan")
          ),
          SizedBox(height: 20),
          Text(_nfcData.toString()),
        ],
      ),
    );
  }
}
