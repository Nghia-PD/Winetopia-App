import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:winetopia_app/models/nfc.dart';
import 'package:winetopia_app/services/firebase_auth.dart';
import 'package:winetopia_app/services/firebase_firestore.dart';
import 'package:winetopia_app/shares/nfc_state.dart';

/// Provides methods for managing NFC interactions, including starting NFC sessions
/// and processing NFC tags.
class NfcService {
  NfcService._();

  static final NfcService instance = NfcService._();

  /// Starts an NFC session and processes NFC tags.
  Future<void> startNfcSession(
    BuildContext context,
    Function(NfcStateEnum) onStateUpdate,
  ) async {
    bool isAvailable = await NfcManager.instance.isAvailable();

    if (isAvailable) {
      onStateUpdate(NfcStateEnum.scanning);

      try {
        await NfcManager.instance.startSession(
          onError: (error) async {
            onStateUpdate(NfcStateEnum.error);
            NfcManager.instance.stopSession();
          },
          onDiscovered: (NfcTag tag) async {
            try {
              await _processTag(tag, context, onStateUpdate);
            } catch (e) {
              print(e);
              onStateUpdate(NfcStateEnum.error);
            } finally {
              NfcManager.instance.stopSession();
            }
          },
        );
      } catch (e) {
        onStateUpdate(NfcStateEnum.error);
      }
    } else {
      onStateUpdate(NfcStateEnum.notAvailable);
    }
  }

  /// Extracts data from the NFC tag and calls [_handleWinePurchase] if the tag
  /// contains valid information.
  Future<void> _processTag(
    NfcTag tag,
    BuildContext context,
    Function(NfcStateEnum) onStateUpdate,
  ) async {
    var tech = Ndef.from(tag);
    if (tech is Ndef) {
      final cachedMessage = tech.cachedMessage;

      if (cachedMessage != null) {
        for (var record in cachedMessage.records) {
          final wineDocId = NdefRecordInfo.fromNdef(record).title;

          await _handleWinePurchase(wineDocId, context, onStateUpdate);
        }
      }
    } else {
      onStateUpdate(NfcStateEnum.error);
    }
  }

  /// Performs the wine purchase using [FirestoreService], and updates the NFC state
  /// based on the purchase outcome.
  Future<void> _handleWinePurchase(
    String wineDocId,
    BuildContext context,
    Function(NfcStateEnum) onStateUpdate,
  ) async {
    try {
      final currentAttendee = AuthService().currentUser;

      final uid = currentAttendee!.uid;

      final wineSample = await FirestoreService(
        uid: uid,
      ).updateBalance(wineDocId);

      if (wineSample != null) {
        onStateUpdate(NfcStateEnum.success);
      } else {
        onStateUpdate(NfcStateEnum.error);
      }
    } catch (e) {
      if (e is InsufficientBalanceException) {
        onStateUpdate(NfcStateEnum.insufficientTokens);
      } else {
        onStateUpdate(NfcStateEnum.error);
      }
    }
  }
}
