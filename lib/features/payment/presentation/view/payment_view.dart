import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/features/payment/presentation/view/toggle_payment_view.dart';
import 'package:payment_app/features/payment/presentation/viewmodel/cubit/payment_cubit.dart';
import 'package:payment_app/core/widgets/default_textfield.dart';

import '../../../../../core/widgets/default_button.dart';

class PaymentView extends StatelessWidget {
  PaymentView({Key? key}) : super(key: key);
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit()..getPaymentAuthRequest(),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is GetPaymentKeySuccessState) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ToggleScreen(),
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Payment Integration'),
              backgroundColor: Colors.teal.shade400,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Container(
                        // child: Image.asset(
                        //   'assets/deliver.png',
                        //   width: MediaQuery.of(context).size.width,
                        //   height: MediaQuery.of(context).size.height * 0.42,
                        // ),
                        ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DefaultTextFormFiled(
                                  controller: firstNameController,
                                  type: TextInputType.name,
                                  hintText: 'First name',
                                  prefix: Icons.person,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your first name!';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: DefaultTextFormFiled(
                                  controller: lastNameController,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your last name !';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.name,
                                  hintText: 'Last name',
                                  prefix: Icons.person,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          DefaultTextFormFiled(
                            controller: emailController,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email  !';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                            hintText: 'Email',
                            prefix: Icons.email,
                          ),
                          const SizedBox(height: 10),
                          DefaultTextFormFiled(
                            controller: phoneController,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone !';
                              }
                              return null;
                            },
                            type: TextInputType.number,
                            hintText: 'Phone',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(height: 10),
                          DefaultTextFormFiled(
                            controller: priceController,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your price !';
                              }
                              return null;
                            },
                            type: TextInputType.number,
                            hintText: 'Price',
                            prefix: Icons.monetization_on,
                          ),
                          const SizedBox(height: 20),
                          DefaultButton(
                            buttonWidget: const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                letterSpacing: 1.6,
                              ),
                            ),
                            function: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<PaymentCubit>(context)
                                    .getOrderRegistrationID(
                                        price: priceController.text,
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text);
                              }
                            },
                            width: MediaQuery.of(context).size.width,
                            radius: 10.0,
                            backgroundColor: Colors.teal.shade300,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
