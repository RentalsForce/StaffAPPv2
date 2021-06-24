import 'package:bn_staff/bloc/login/login_bloc.dart';
import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/pages_v2/tasks_home.dart';
import 'package:bn_staff/util/dio.dart';
import 'package:bn_staff/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../widgets/input_view.dart';
import 'package:email_validator/email_validator.dart';

class LoginView extends StatefulWidget {
  LoginView();

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool isTest = true;

  bool showCompany = false;

  bool errorEmail = false;

  bool alreadyInProgress = false;

  TextEditingController controllerEmail = TextEditingController();

  TextEditingController controllerPassword = TextEditingController();

  bool errorPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                EasyLoading.dismiss();
                EasyLoading.showToast('Loaded in successfully');
                alreadyInProgress = false;
                Route route = MaterialPageRoute(
                  builder: (context) => TasksHome(),
                );
                Navigator.pushReplacement(context, route);
              } else if (state is LoginLoaing) {
                EasyLoading.show(
                  status: 'loading...',
                );
              } else if (state is LoginErrorState) {
                alreadyInProgress = false;

                EasyLoading.showToast(
                  'Invalid Credential entered',
                );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is InitialLoginState || state is LoginErrorState) {
                  return Column(
                    children: [
                      Image(
                        image: AssetImage(
                          'asset/images/logo.png',
                        ),
                        width: 120,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Please, fill the below information to Log in',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        children: [
                          InputView(
                            controller: this.controllerEmail,
                            showError: this.errorEmail,
                            placeHolder: 'Please Enter username',
                            isSecure: false,
                          ),
                          InputView(
                            controller: this.controllerPassword,
                            showError: this.errorPassword,
                            placeHolder: 'Please Enter your password',
                            isSecure: true,
                          ),
                          Row(children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Use test server',
                              style: TextStyle(fontSize: 17.0),
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: PColors.blue,
                              value: this.isTest,
                              onChanged: (bool value) {
                                setState(
                                  () {
                                    isTest = value;
                                  },
                                );
                              },
                            ),
                          ]),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: PElevatedButton(
                          text: 'LOG IN',
                          onPressed: () {

                            bool flag = true;

                            if (controllerEmail.value.text.isEmpty) {
                              flag = false;
                            }
                            //flag = flag &&
                            //  EmailValidator.validate(controllerEmail.value.text);

                            setState(
                              () {
                                this.errorEmail = !flag;
                              },
                            );

                            if (controllerPassword.value.text.isEmpty) {
                              flag = false;

                              setState(
                                () {
                                  this.errorPassword = true;
                                },
                              );
                            } else {
                              setState(
                                () {
                                  this.errorPassword = false;
                                },
                              );
                            }
                            if (flag == true) {
                              print('Correct');

                              this.alreadyInProgress = true;

                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginButtonTapped(
                                      username: controllerEmail.value.text,
                                      password: controllerPassword.value.text,
                                      isTest: isTest));
                            } else {}
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
