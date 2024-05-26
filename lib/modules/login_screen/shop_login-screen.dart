// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/modules/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text('Login now to browse our new offer',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.grey)),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              labelText: 'Email',
                              prefix: Icons.email,
                              onChanged: (String s){
                                s = emailController.value.toString();
                                print(s);
                              }
                              ,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is too short';
                                }
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            labelText: 'Password',
                            prefix: Icons.remove_red_eye_outlined,
                              onChanged: (String s){
                                s = passwordController.value.toString();
                                print(s);
                              }
                              ,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is too short';
                                }
                              }

                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (_) => defaultButton(
                                function: () {
                                  if(formKey.currentState!.validate()){
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,);
                                    print("object");
                                  }
                                },
                                text: 'Login',
                              ),
                              fallback: (_)=> const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account ?",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              defaultTextButton(function: () {
                                navigateTo(context, const ShopRegisterScreen());
                              }, text: 'REGISTER'),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
