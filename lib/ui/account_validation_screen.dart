import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripus/bloc/bank_account_validation/bank_account_validation_bloc.dart';
import 'package:stripus/bloc/payment/payment_bloc.dart';
import 'package:stripus/repository/account_validation_repository.dart';
import 'package:stripus/repository/payment_repository.dart';
import 'package:sweetalert/sweetalert.dart';

class AccountValidationScreen extends StatefulWidget {
  AccountValidationScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AccountValidationScreenState createState() => _AccountValidationScreenState();
}

class _AccountValidationScreenState extends State<AccountValidationScreen> {

  BankAccountValidationBloc accountValidationBloc;
  String accountNumber, sortCodes;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => BankAccountValidationBloc(accountValidationRepository: AccountValidationRepository()),
      child: Builder(builder: (context) {
        accountValidationBloc = BlocProvider.of<BankAccountValidationBloc>(context);
       return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Container(padding:EdgeInsets.only(left: 10,right: 10),
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                        TextFormField(
                          validator: (input) => input.trim().isEmpty
                              ? 'Please the account number'
                              : null,
                          onSaved: (input) => accountNumber = input,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: "Account Number",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (input) => input.trim().isEmpty
                            ? 'Please the sort code'
                            : null,
                        onSaved: (input) => accountNumber = input,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: "Sort code",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            accountValidationBloc.add(ValidateBankAccount(accountNumber, sortCodes));
                          }
                        },
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        child: Text("Validate Account"),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 32.0,
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      BlocConsumer<BankAccountValidationBloc, BankAccountValidationState>(listener: (context, state) {
                        if(state is BankAccountValidationLoading){
                          return CircularProgressIndicator();
                        } else if(state is BankAccountValidationLoaded){
                          return Text(state.accountValidation.toString());
                        }else if(state is BankAccountValidationError){
                          return Text(state.message);
                        }
                        return Container();
                      },builder: (context, state) {
                        if(state is BankAccountValidationLoading){
                          return CircularProgressIndicator();
                        }else if(state is BankAccountValidationLoaded){
                          return  Text(state.accountValidation.toString());
                        }
                        return Container();
                      },)
                    ],
                  ),
                ),
              ),
            ),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
      ),
    );
  }
}
