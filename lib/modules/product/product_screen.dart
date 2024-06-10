import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoriteState) {
          if (!state.model.status) {
            showToast(text: state.model.message, state: ToastState.ERROR);
          }
        }
        if (state is ShopErrorChangeFavoriteState) {
          showToast(text: 'Error has occurred', state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: (cubit.homeModel != null && cubit.categoryModel != null),
          builder: (context) =>
              productBuilder(cubit.homeModel, cubit.categoryModel, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(HomeModel? model, CategoryModel? catModel, context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: model?.data?.banners
                .map(
                  (e) => Image(
                      image: NetworkImage(
                        e.image,
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          const Text('Error Loading Image'),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      }),
                )
                .toList(),
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 7),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1,
              reverse: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCatItem(catModel.data?.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                      itemCount: catModel!.data!.data.length),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 2),
            color: Colors.grey[300],
            child: GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.5,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                model!.data!.products.length,
                (index) =>
                    buildGridProduct(model.data!.products[index], context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model, context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              SizedBox(
                height: 200,
                child: Image.network(
                  model.image,
                  errorBuilder: (context, error, stackTrace) =>
                      const Image(image: AssetImage('assets/images/img.png')),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  width: double.infinity,
                  height: 200,
                ),
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                  child: const Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
            ]),
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  model.price.toString(),
                  style: const TextStyle(
                    color: defaultColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (model.discount != 0)
                  Text(model.oldPrice.toString(),
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      )),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorite(model.id);
                    },
                    icon: ShopCubit.get(context).favorites[model.id]!
                        ? const Icon(
                            Icons.favorite,
                            color: defaultColor,
                          )
                        : const Icon(Icons.favorite_border_outlined)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildCatItem(CatDataModel? model) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(
            model!.image,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            color: Colors.grey,
            child: Text(
              textAlign: TextAlign.center,
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
