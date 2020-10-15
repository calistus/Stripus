import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripus/bloc/payment/payment_bloc.dart';
import 'package:stripus/repository/account_validation_repository.dart';
import 'package:stripus/repository/payment_repository.dart';
import 'package:stripus/ui/account_validation_screen.dart';
import 'package:sweetalert/sweetalert.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PaymentBloc paymentBloc;

  @override
  void initState() {
    StripeRepository.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => PaymentBloc(stripeRepository: StripeRepository()),
      child: Builder(builder: (context) {
        paymentBloc = BlocProvider.of<PaymentBloc>(context);
       return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocListener<PaymentBloc, PaymentState>(listener: (context, state) {
                  if (state is PaymentSuccessful){
                    SweetAlert.show(context,
                        title: "Payment successful",
                        subtitle: "${state.response.message}",
                        style: SweetAlertStyle.success);
                  }else if(state is PaymentError){
                    SweetAlert.show(context,
                        title: "Something went wrong",
                        subtitle: "${state.response.message}",
                        style: SweetAlertStyle.error);
                  }
                },child: Container(),),
                RaisedButton(
                  onPressed: () {
                    paymentBloc.add(PayWithCard("10000", "GBP", "icalistus@gmail.com", "Test Payment Calistus"));
                  },
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  child: Text("Pay \£1000"),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 32.0,
                  ),
                ),
                RaisedButton(
                  onPressed: () async{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountValidationScreen(title: 'Account Validation'),));
                     },
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  child: Text("Validate a UK account number"),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 32.0,
                  ),
                )
              ],
            ),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
      ),
    );
  }
}
