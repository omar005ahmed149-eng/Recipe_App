import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipes/APIservice/Get_Resources.dart';
import '../../../../APIservice/Categories.dart';
import '../../../../core/resources/assets_manger.dart';
import '../../../../core/widgets/Category_card.dart';
import '../bloc/home_bloc.dart';


class TopSection extends StatefulWidget {
  const TopSection({super.key, required this.activeIndex});

  final int activeIndex;

  static final PageController _pageController = PageController(
    viewportFraction: 0.62,
  );

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  late Future<List<Categories>?> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = GetResponse.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 56.h),

        Image.asset(AssetsManger.available),

        SizedBox(height: 16.h),

        SizedBox(
          height: 360.h,
          child: FutureBuilder(
            future: _categoriesFuture,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Error"));
              }
              List<Categories> categories = snapshot.data ?? [];

              return PageView.builder(
                controller: TopSection._pageController,
                itemCount: categories.length,

                onPageChanged: (index) {

                  context.read<HomeBloc>().add(
                    HomePageChanged(
                      index,
                      categories[index].strCategoryThumb ?? '',
                    ),
                  );
                },

                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                    child: CategoryCard(
                      mealName: categories[index].strCategory ?? "",
                      poster_image: categories[index].strCategoryThumb ?? "",
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
