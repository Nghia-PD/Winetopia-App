import 'package:nfc_manager/nfc_manager.dart';

class NfcService {
  dynamic tagRead() async {
    dynamic result;
    await NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        result = tag.data;
        NfcManager.instance.stopSession();
      },
    );
    return result;
  }
}
