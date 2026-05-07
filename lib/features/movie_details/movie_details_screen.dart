import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:recipes/core/models/recipe_Model.dart';
import 'package:recipes/core/resources/colors_manger.dart';

import '../../core/bloc/reciepes/reciepes_cubit.dart';
import '../../core/bloc/reciepes/reciepes_state.dart';

class recipeDetailsScreen extends StatefulWidget {
  final ReciepeModel recipe;
  const recipeDetailsScreen({super.key, required this.recipe});

  @override
  State<recipeDetailsScreen> createState() => _recipeDetailsScreenState();
}

class _recipeDetailsScreenState extends State<recipeDetailsScreen> {
  static const Map<String, _recipeMeta> _meta = {
    '1917': _recipeMeta(year: '2019', likes: 18, duration: 119, rating: 8.3,
        summary:
            'April 6th, 1917. As a regiment assembles to wage war deep in enemy territory, two young British soldiers are chosen to deliver a message that could potentially save 1,600 of their comrades — and the brothers of one of the soldiers.'),
    'Baby Driver': _recipeMeta(year: '2017', likes: 21, duration: 113, rating: 7.6,
        summary:
            'After being coerced into working for a crime boss, a young getaway driver finds himself taking part in a heist doomed to fail.'),
    'Captain America': _recipeMeta(year: '2011', likes: 15, duration: 124, rating: 6.9,
        summary:
            'Steve Rogers, a rejected military soldier, transforms into Captain America after taking a dose of a Super-Soldier serum. But being Captain America comes at a price as he attempts to take down a war monger.'),
    'The Dark Knight': _recipeMeta(year: '2008', likes: 45, duration: 152, rating: 9.0,
        summary:
            'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.'),
    'Black Widow': _recipeMeta(year: '2021', likes: 14, duration: 134, rating: 6.7,
        summary:
            'Natasha Romanoff confronts the darker parts of her ledger when a dangerous conspiracy with ties to her past arises. Pursued by a force that will stop at nothing to bring her down, Natasha must deal with her history as a spy.'),
    'Joker': _recipeMeta(year: '2019', likes: 38, duration: 122, rating: 8.4,
        summary:
            'In Gotham City, mentally-troubled comedian Arthur Fleck embarks on a downward-spiral of social revolution and bloody crime. This path brings him face-to-face with his alter-ego: "The Joker".'),
    'Iron Man 3': _recipeMeta(year: '2013', likes: 12, duration: 130, rating: 7.1,
        summary:
            'When Tony Stark\'s world is torn apart by a formidable terrorist called the Mandarin, he starts an odyssey of rebuilding and retribution.'),
    'Avengers': _recipeMeta(year: '2012', likes: 29, duration: 143, rating: 8.0,
        summary:
            'Nick Fury of S.H.I.E.L.D. assembles a team of superheroes to save the planet from Loki and his army.'),
    'Doctor Strange': _recipeMeta(year: '2016', likes: 16, duration: 115, rating: 7.5,
        summary:
            'While on a journey of physical and spiritual healing, a brilliant neurosurgeon is drawn into the world of the mystic arts.'),
    'Wednesday': _recipeMeta(year: '2022', likes: 33, duration: 45, rating: 8.1,
        summary:
            'Follows Wednesday Addams\' years as a student at Nevermore Academy, where she attempts to master her emerging psychic ability, thwart a monstrous killing spree that has terrorized the local town, and solve the supernatural mystery that embroiled her parents.'),
    'Doctor Who': _recipeMeta(year: '2013', likes: 27, duration: 60, rating: 9.1,
        summary:
            'The Doctor\'s many incarnations team up to save Gallifrey from total destruction in The Day of the Doctor, the 50th anniversary special.'),
    'Godzilla': _recipeMeta(year: '2014', likes: 19, duration: 123, rating: 6.4,
        summary:
            'The world is beset by the appearance of monstrous creatures, but one of them may be the only one who can prevent an extinction-level event.'),
  };

  static const List<Color> _screenshotColors = [
    Color(0xFF1A2A4A),
    Color(0xFF3A1A1A),
    Color(0xFF1A3A2A),
    Color(0xFF2A2A1A),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReciepesCubit>().addToHistory(widget.recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    final meta = _meta[widget.recipe.title] ??
        _recipeMeta(
            year: '2020',
            likes: 10,
            duration: 100,
            rating: double.parse(widget.recipe.rating),
            summary: 'An exciting recipe you will love watching.');

    return BlocBuilder<ReciepesCubit, ReciepesState>(
      builder: (context, state) {
        final isBookmarked = context.read<ReciepesCubit>().isBookmarked(widget.recipe);
        return Scaffold(
          backgroundColor: ColorsManger.black,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280.h,
                pinned: true,
                backgroundColor: ColorsManger.black,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? ColorsManger.yellow : Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      context.read<ReciepesCubit>().toggleBookmark(widget.recipe);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: ColorsManger.darkGray,
                          duration: const Duration(seconds: 1),
                          content: Text(
                            context.read<ReciepesCubit>().isBookmarked(widget.recipe)
                                ? '✓ Added to Watch List'
                                : 'Removed from Watch List',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        widget.recipe.poster_image,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x33000000),
                              Color(0x00000000),
                              Color(0xCC000000),
                              Color(0xFF121312),
                            ],
                            stops: [0.0, 0.3, 0.75, 1.0],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 60.r,
                          height: 60.r,
                          decoration: BoxDecoration(
                            color: ColorsManger.yellow,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: ColorsManger.yellow.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(Icons.play_arrow_rounded,
                              color: Colors.black, size: 32.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),

                      Text(
                        widget.recipe.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        meta.year,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 14.h),

                      SizedBox(
                        width: double.infinity,
                        height: 46.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManger.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Watch',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      Row(
                        children: [
                          _StatChip(
                            icon: Icons.favorite,
                            color: ColorsManger.yellow,
                            label: meta.likes.toString(),
                          ),
                          SizedBox(width: 16.w),
                          _StatChip(
                            icon: Icons.access_time_filled,
                            color: const Color(0xFF888888),
                            label: '${meta.duration}',
                          ),
                          SizedBox(width: 16.w),
                          _StatChip(
                            icon: Icons.star,
                            color: Colors.amber,
                            label: meta.rating.toString(),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      _SectionTitle(title: 'Screen Shots'),
                      SizedBox(height: 12.h),
                      ..._buildScreenshots(context),

                      SizedBox(height: 24.h),

                      _SectionTitle(title: 'Similar'),
                      SizedBox(height: 12.h),
                      _SimilarrecipesGrid(currentrecipe: widget.recipe),

                      SizedBox(height: 24.h),

                      _SectionTitle(title: 'Summary'),
                      SizedBox(height: 8.h),
                      Text(
                        meta.summary,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.sp,
                          height: 1.55,
                        ),
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildScreenshots(BuildContext context) {
    final screenshots = [
      _ScreenshotData(color: const Color(0xFF0A1628), icon: Icons.location_city, label: 'City Chase'),
      _ScreenshotData(color: const Color(0xFF1A0A0A), icon: Icons.local_fire_department, label: 'Action Scene'),
      _ScreenshotData(color: const Color(0xFF0A1A10), icon: Icons.forest, label: 'Outdoor Scene'),
    ];

    return [
      SizedBox(
        height: 160.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: screenshots.length,
          separatorBuilder: (_, __) => SizedBox(width: 10.w),
          itemBuilder: (_, i) => ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              width: 220.w,
              color: screenshots[i].color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(screenshots[i].icon, color: Colors.white38, size: 40.r),
                  SizedBox(height: 8.h),
                  Text(
                    screenshots[i].label,
                    style: TextStyle(color: Colors.white38, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];
  }
}


class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  const _StatChip({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18.r),
        SizedBox(width: 4.w),
        Text(label,
            style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _SimilarrecipesGrid extends StatelessWidget {
  final ReciepeModel currentrecipe;
  const _SimilarrecipesGrid({required this.currentrecipe});

  @override
  Widget build(BuildContext context) {
    final allrecipes = _similarPool
        .where((m) => m['title'] != currentrecipe.title)
        .take(4)
        .toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
      ),
      itemCount: allrecipes.length,
      itemBuilder: (_, i) {
        final m = allrecipes[i];
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(m['poster']!, fit: BoxFit.cover),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: ColorsManger.yellow, size: 12.r),
                      SizedBox(width: 3.w),
                      Text(m['rating']!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static const _similarPool = [
    {'title': 'Black Widow', 'poster': 'assets/images/Black_Widow.jpg', 'rating': '7.7'},
    {'title': 'Captain America', 'poster': 'assets/images/Captain_America.jpg', 'rating': '7.7'},
    {'title': 'Avengers', 'poster': 'assets/images/Avengers.jpg', 'rating': '8.0'},
    {'title': 'Doctor Strange', 'poster': 'assets/images/doctor_strange.jpg', 'rating': '7.5'},
    {'title': 'Joker', 'poster': 'assets/images/joker.jpg', 'rating': '8.4'},
    {'title': 'Iron Man 3', 'poster': 'assets/images/iron_man_3.jpg', 'rating': '7.1'},
    {'title': '1917', 'poster': 'assets/images/1917_Poster.jpg', 'rating': '8.3'},
    {'title': 'Godzilla', 'poster': 'assets/images/godzilla.jpg', 'rating': '7.3'},
  ];
}


class _recipeMeta {
  final String year;
  final int likes;
  final int duration;
  final double rating;
  final String summary;
  const _recipeMeta({
    required this.year,
    required this.likes,
    required this.duration,
    required this.rating,
    required this.summary,
  });
}

class _ScreenshotData {
  final Color color;
  final IconData icon;
  final String label;
  const _ScreenshotData({required this.color, required this.icon, required this.label});
}
