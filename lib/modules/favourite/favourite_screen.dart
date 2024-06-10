import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_layout/cubit/cubit.dart';
import '../../layout/shop_layout/cubit/states.dart';
import '../../shared/components/components.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).favorites.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildFavItem(
                  ShopCubit.get(context)
                      .favoritesModel!
                      .data!
                      .data![index]
                      .product!,
                  context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount:
                  ShopCubit.get(context).favoritesModel!.data!.data!.length),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
