import 'package:flutter/material.dart';
import 'package:winetopia_app/models/attendee.dart';
import 'package:winetopia_app/screens/home/nfc.dart';
import 'package:winetopia_app/shares/setting.dart';
import 'package:winetopia_app/shares/widgets.dart';

class HomeContent extends StatelessWidget {
  final AttendeeModel attendeeData;
  HomeContent({required this.attendeeData, super.key});

  Widget _topUpButton() {
    return ElevatedButton(
      onPressed: () async {
        print("Top Up!");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Setting().buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // wrap content
        children: [
          Text(
            'Top up',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(width: 8),
          Icon(Icons.add_circle, color: Colors.white),
        ],
      ),
    );
  }

  Widget _withdrawButton() {
    return ElevatedButton(
      onPressed: () async {
        print("Withdraw!");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Setting().buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // wrap content
        children: [
          Text(
            'Withdraw',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(width: 8),
          Icon(Icons.remove_circle, color: Colors.white),
        ],
      ),
    );
  }

  Widget _balanceContainer(String goldBalance, String silverBalance) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Setting().borderLineColor, width: 2.0),
        borderRadius: BorderRadius.circular(20),
      ),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gold',
                          style: TextStyle(
                            color: Setting().textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  goldBalance,
                  style: TextStyle(
                    color: Setting().textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Silver',
                          style: TextStyle(
                            color: Setting().textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  silverBalance,
                  style: TextStyle(
                    color: Setting().textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: SizedBox(height: 40, child: _topUpButton())),
              SizedBox(width: 50),
              Expanded(child: SizedBox(height: 40, child: _withdrawButton())),
            ],
          ),
        ],
      ),
    );
  }

  final List<String> transactions = [
    '\$20 to Exhibitor 2',
    '\$50 to Exhibitor 1',
    '\$20 to Exhibitor 2',
    '\$100 to Supper Important Exhibitor',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
  ];

  final List<String> subTitles = [
    '\$20 to Exhibitor 2',
    '\$50 to Exhibitor 1',
    '\$20 to Exhibitor 2',
    '\$100 to Supper Important Exhibitor',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
    '\$20 to Exhibitor 2',
  ];

  Widget _transactionsHistory() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(), // prevent double scroll
      shrinkWrap: true,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text(transactions[index]),
          subtitle: Text(subTitles[index]),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final goldBalance = attendeeData.goldCoin;
    final silverBalance = attendeeData.silverCoin;

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),

        width: double.infinity,
        padding: EdgeInsets.only(
          left: Setting().yPaddingInHome,
          right: Setting().yPaddingInHome,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Widgets().titleInHome("Wallet"),
            ),
            SizedBox(height: 10),
            _balanceContainer(goldBalance.toString(), silverBalance.toString()),
            NfcContainer(),
            Align(
              alignment: Alignment.topLeft,
              child: Widgets().titleInHome("Transaction History"),
            ),
            _transactionsHistory(),
          ],
        ),
      ),
    );
  }
}
