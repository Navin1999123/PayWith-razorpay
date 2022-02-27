import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  late var _razorpay;
  var amountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Flushbar(
      message: response.toString(),
      animationDuration: Duration(seconds: 6),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Flushbar(
      message: response.toString(),
      animationDuration: Duration(seconds: 6),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Flushbar(
      message: response.toString(),
      animationDuration: Duration(seconds: 6),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 199, 219),
      appBar: const CupertinoNavigationBar(
        middle: Text("Pay with Navin"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.verified_user_outlined,
              size: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: TextField(
                controller: amountController,
                decoration:
                    const InputDecoration(hintText: "Enter your Amount"),
              ),
            ),
            ElevatedButton(
                child: const Text("Pay Amount"),
                onPressed: () {
                  var options = {
                    'key': "rzp_test_FiZnKXLVFyvpQl",
                    'amount': (int.parse(amountController.text) * 100)
                        .toString(), //So its pay 500
                    'name': 'navin',
                    'description': 'Demo',
                    'timeout': 60, // in seconds
                    'prefill': {
                      'contact': '9520757004',
                      'email': 'navinkumarnkh@gmail.com'
                    }
                  };
                  try {
                    _razorpay.open(options);
                  } catch (e) {
                    debugPrint('Error: e');
                  }

                  //   _razorpay.open(options);
                  // }
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}
