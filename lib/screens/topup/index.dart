import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:winetopia_app/models/attendee.dart';
import 'package:winetopia_app/services/stripe.dart';

import 'package:winetopia_app/shares/setting.dart';
import 'package:winetopia_app/shares/widgets.dart';

class Topup extends StatefulWidget {
  final AttendeeModel attendeeData;
  const Topup({required this.attendeeData, super.key});

  @override
  State<Topup> createState() => _TopupState();
}

class _TopupState extends State<Topup> {
  final TextEditingController _controllerGold = TextEditingController(
    text: "0",
  );
  final TextEditingController _controllerSilver = TextEditingController(
    text: "0",
  );
  Widget _entryField(TextEditingController controller, bool hideText) {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        obscureText: hideText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Setting().textColor,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: "0",
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // rounded corners
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Setting().borderLineColor),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _nextButton(String email) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: () async {
          int amount = calculateAmount();
          if (amount <= 0) {
            print("cant be less or equal 0");
          } else {
            await StripeService().initPaymentSheet(
              context,
              email: email,
              amount: amount,
            );
          }
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Setting().buttonColor),
        ),
        child: Text("Next", style: TextStyle(color: Setting().textColorLight)),
      ),
    );
  }

  int calculateAmount() {
    int goldQuantity = int.tryParse(_controllerGold.text) ?? 0;
    int silverQuantity = int.tryParse(_controllerSilver.text) ?? 0;
    return goldQuantity * Setting().goldPrice +
        silverQuantity * Setting().silverPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Widgets().appBar(),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/gold-coin.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Gold (\$6 each)',
                        style: TextStyle(
                          color: Setting().textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Flexible(child: _entryField(_controllerGold, false)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/silver-coin.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 10),

                      Text(
                        'Silver (\$2 each)',
                        style: TextStyle(
                          color: Setting().textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Flexible(child: _entryField(_controllerSilver, false)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: _nextButton(widget.attendeeData.email),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
