import 'dart:convert' show ascii, utf8;
import 'dart:typed_data';
import 'package:nfc_manager/nfc_manager.dart';

/// Holds information about an NDEF record, including the text content.
class NdefRecordInfo {
  const NdefRecordInfo({required this.record, required this.title});

  final Record record;
  final String title;

  static NdefRecordInfo fromNdef(NdefRecord record) {
    final ndefRecord = Record.fromNdef(record);
    if (ndefRecord is WellknownTextRecord) {
      return NdefRecordInfo(record: ndefRecord, title: ndefRecord.text);
    }
    throw UnimplementedError(); // Throws error if the record type is not supported.
  }
}

/// Abstract class representing a generic NFC record. Only recognizes well-known NFC text records.
abstract class Record {
  static Record fromNdef(NdefRecord record) {
    if (record.typeNameFormat == NdefTypeNameFormat.nfcWellknown &&
        record.type.length == 1 &&
        record.type.first == 0x54) {
      return WellknownTextRecord.fromNdef(record);
    }
    return UnsupportedRecord(record);
  }
}

/// Represents a well-known NFC text record.
class WellknownTextRecord implements Record {
  WellknownTextRecord({
    this.identifier,
    required this.languageCode,
    required this.text,
  });

  final Uint8List? identifier;
  final String languageCode;
  final String text;

  /// Parses the text and language code from an [NdefRecord].
  ///
  /// Returns a [WellknownTextRecord] instance.
  static WellknownTextRecord fromNdef(NdefRecord record) {
    final languageCodeLength = record.payload.first;
    final languageCodeBytes = record.payload.sublist(1, 1 + languageCodeLength);
    final textBytes = record.payload.sublist(1 + languageCodeLength);
    return WellknownTextRecord(
      identifier: record.identifier,
      languageCode: ascii.decode(languageCodeBytes),
      text: utf8.decode(textBytes),
    );
  }
}

/// Represents an unsupported NFC record type. i.e., all types besides well-known.
class UnsupportedRecord implements Record {
  UnsupportedRecord(this.record);

  final NdefRecord record;

  static UnsupportedRecord fromNdef(NdefRecord record) {
    return UnsupportedRecord(record);
  }
}
