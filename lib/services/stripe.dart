import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  Future<String> initPaymentSheet(
    context, {
    required String email,
    required int amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "https://australia-southeast1-winetopia-db6ec.cloudfunctions.net/stripePaymentIntentRequest",
        ),
        body: {'email': email, 'amount': amount.toString()},
      );
      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'Flutter Stripe Store Demo',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.light,
        ),
      );
      await Stripe.instance.presentPaymentSheet();

      return "Success";
    } catch (e) {
      return '';
    }
  }
}
