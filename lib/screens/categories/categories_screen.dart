import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/theme.dart';
import '/models/categories_model.dart';
import '/screens/shop/cubit/cubit.dart';
import '/screens/shop/cubit/state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: ShopCubit.get(context).categoriesModel != null,
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (context) =>
            categoriesBuilder(ShopCubit.get(context).categoriesModel!),
      ),
    );
  }

  Widget categoriesBuilder(CategoriesModel categoriesModel) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: List.generate(
        categoriesModel.data.data.length,
        (index) => categoryBuild(categoriesModel, index),
      ),
    );
  }

  Widget categoryBuild(CategoriesModel categoriesModel, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 5.0,
      ),
      child: Card(
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FadeInImage(
                image: NetworkImage(categoriesModel.data.data[index].image),
                placeholder: const AssetImage('assets/default/default.jpg'),
                width: 80.0,
                height: 80.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                categoriesModel.data.data[index].name,
                style: ShopTheme.lightText.bodyText1,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward),
            const SizedBox(
              width: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
