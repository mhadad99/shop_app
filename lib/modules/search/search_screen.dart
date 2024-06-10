import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  TextEditingController searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Enter what you want to search';
                        }
                      },
                      labelText: 'Search',
                      prefix: Icons.search,
                      onSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          ShopSearchCubit.get(context).userSearch(
                            text: searchController.text,
                          );
                        }
                      },
                    ),
                    if (state is ShopSearchLoadingState)
                      const LinearProgressIndicator(),
                    if (state is ShopSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildFavItem(
                                ShopSearchCubit.get(context)
                                    .searchModel
                                    ?.data!
                                    .data?[index],
                                context,
                                oldPrice: false),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: ShopSearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data!
                                .length),
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
