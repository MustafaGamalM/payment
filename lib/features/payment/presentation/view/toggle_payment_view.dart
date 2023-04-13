import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/core/app_constatns.dart';
import 'package:payment_app/features/payment/presentation/view/ref_code_view.dart';
import 'package:payment_app/features/payment/presentation/view/visa_view.dart';
import 'package:payment_app/features/payment/presentation/viewmodel/cubit/payment_cubit.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is GetRefCodeSuccessState) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ReferenceScreen(),
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<PaymentCubit>(context).getRefCode();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.black87, width: 2.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: NetworkImage(AppImages.refCodeImage),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Payment with Ref code',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const VisaScreen(),
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.black, width: 2.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Image(
                              image: NetworkImage(AppImages.visaImage),
                            ),
                            Text(
                              'Payment with visa',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
