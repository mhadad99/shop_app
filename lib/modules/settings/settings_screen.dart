import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data.name!;
        emailController.text = model.data.email!;
        phoneController.text = model.data.phone!;

        return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.none,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not be Empty';
                            }
                          },
                          labelText: 'Name',
                          prefix: Icons.person_outline,
                          //readonly: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.none,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email must not be Empty';
                            }
                          },
                          labelText: 'Email',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.none,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be Empty';
                            }
                          },
                          labelText: 'Phone',
                          prefix: Icons.phone,
                          //readonly: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultButton(
                            function: () {
                              signOut(context);
                            },
                            text: "Sign Out")
                      ],
                    ),
                  ),
                ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
      //buildWhen: (previous, current) => ,
      listener: (context, state) {
        if (ShopLoginCubit.get(context).isClosed) {
          ShopCubit.get(context).getUserData();
          ShopCubit.get(context).state;
        }
      },
      listenWhen: (previous, current) => ShopLoginCubit.get(context).isClosed,
    );
  }
}
