import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/constants.dart';

import '../../layout/shop_layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.registerModel.data.token)
                  .then((onValue) {
                if (onValue) {
                  showToast(
                    text: state.registerModel.message!,
                    state: ToastState.SUCCESS,
                  );
                  token = state.registerModel.data.token!;
                  navigateAndFinish(context, const ShopLayout());
                }
              });
            } else {
              showToast(
                text: state.registerModel.message!,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
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
                            'Register',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text('Register now to browse our new offer',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.grey)),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              labelText: 'Name',
                              prefix: Icons.person_outline,
                              onChanged: (String s) {
                                s = emailController.value.toString();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Name is too short';
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              labelText: 'Email',
                              prefix: Icons.email,
                              onChanged: (String s) {
                                s = emailController.value.toString();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is too short';
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              labelText: 'Phone Number',
                              prefix: Icons.phone,
                              onChanged: (String s) {
                                s = emailController.value.toString();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone is too short';
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              labelText: 'Password',
                              prefix: Icons.lock_outline,
                              suffix: ShopRegisterCubit.get(context).suffix,
                              isPassword:
                                  ShopRegisterCubit.get(context).isPassword,
                              suffixPressed: () {
                                ShopRegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              onChanged: (String s) {
                                s = passwordController.value.toString();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is too short';
                                }
                              },
                              onSubmitted: (value) {}),
                          const SizedBox(
                            height: 35,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (_) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'Register',
                            ),
                            fallback: (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
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
