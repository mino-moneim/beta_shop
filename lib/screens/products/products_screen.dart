import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/models/models.dart';
import '/screens/shop/cubit/cubit.dart';
import '/screens/shop/cubit/state.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopFavoritesSuccessState) {
          if (!state.model.status) {
            Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) => ConditionalBuilder(
        condition: ShopCubit.get(context).homeModel != null,
        builder: (context) =>
            productsBuilder(ShopCubit.get(context).homeModel!, context),
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  int _currentIndex = 0;

  Widget productsBuilder(HomeModel model, BuildContext context) =>
      SingleChildScrollView(
        child: ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5.0,
              ),
              CarouselSlider(
                items: model.data.banners
                    .map(
                      (banner) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: FadeInImage(
                              image: NetworkImage(banner.image),
                              placeholder: const AssetImage(
                                'assets/default/default.jpg',
                              ),
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    height: 180.0,
                    initialPage: 0,
                    // viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: model.data.banners.map((banner) {
                  int index = model.data.banners.indexOf(banner);
                  return Container(
                    height: 6.0,
                    width: 6.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 2.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Colors.purpleAccent
                          : Colors.grey[200],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 1 / 1.7,
                  children: List.generate(
                    model.data.products.length,
                    (index) => productBuild(model.data.products[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget productBuild(ProductsModel model) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FadeInImage(
                    width: 150.0,
                    height: 170.0,
                    image: NetworkImage(model.image),
                    placeholder: const AssetImage('assets/default/default.jpg'),
                  ),
                ),
              ),
              Row(
                children: [
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'DISCOUNT',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  const Spacer(),
                  if (model.discount != 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 4.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  'price : ${model.price.round()}',
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
                const Spacer(),
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
          ),
        ],
      ),
    );
  }
}
