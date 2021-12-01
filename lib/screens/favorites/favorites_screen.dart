import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/models/models.dart';
import '/screens/shop/cubit/cubit.dart';
import '/screens/shop/cubit/state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => SafeArea(
        child: ConditionalBuilder(
          condition: ShopCubit.get(context).favoritesModel != null,
          builder: (context) => ShopCubit.get(context).favoritesModel!.status
              ? ListView.separated(
                  itemBuilder: (context, index) => favoriteBuilder(
                    ShopCubit.get(context)
                        .favoritesModel!
                        .data
                        .data[index]
                        .product,
                    context,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5.0,
                  ),
                  itemCount:
                      ShopCubit.get(context).favoritesModel!.data.data.length,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          fallback: (context) => const Center(
            child: Text('favorites is empty.'),
          ),
        ),
      ),
    );
  }

  Widget favoriteBuilder(ProductModel model, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 2.0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FadeInImage(
                      width: 100.0,
                      height: 100.0,
                      image: NetworkImage(model.image),
                      placeholder:
                          const AssetImage('assets/default/default.jpg'),
                    ),
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Text(
                        'DISCOUNT',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  IconButton(
                    icon: Icon(
                      ShopCubit.get(context).favorites[model.id]!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
