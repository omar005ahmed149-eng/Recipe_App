import 'package:recipes/core/resources/assets_manger.dart';

import 'recipe_Model.dart';
class ReciepeData{

static final List<ReciepeModel> featuredReciepes = [
  ReciepeModel(
    title: '1917',
    rating: "7.7",
    poster_image:AssetsManger.Poster_1917,

  ),
  ReciepeModel(
    title: 'Baby Driver',
    rating: "7.6",
    poster_image:AssetsManger.Baby_Driver,
  ),
  ReciepeModel(
    title: 'Captain America',
    rating: "7.7",
    poster_image:AssetsManger.Captain_America,
  ),
  ReciepeModel(
    title: 'The Dark Knight',
    rating:"9.0",
    poster_image: AssetsManger.Dark_Knight,
  ),
  ReciepeModel(
    title: 'Black Widow',
    rating: "7.7",
    poster_image:AssetsManger.Black_Widow,
  ),
  ReciepeModel(
    title: 'Joker',
    rating: "8.1",
    poster_image: AssetsManger.joker,
  ),
ReciepeModel(
    title: 'Iron Man 3',
    rating: "6.9",
  poster_image: AssetsManger.iron_man3,
  ),
ReciepeModel(
    title: 'Avengers',
    rating: "7.0",
    poster_image: AssetsManger.avengers,
  ),
  ReciepeModel(
    title: 'Doctor Strange',
    rating: "7.5",
    poster_image:AssetsManger.dr_strange,
  ),
  ReciepeModel(
    title: 'Wednesday',
    rating: "8.0",
    poster_image: AssetsManger.wednesday,
  ),
  ReciepeModel(
    title: 'Doctor Who',
    rating: "8.2",
    poster_image: AssetsManger.doctor_who,
  ),
  ReciepeModel(
    title: 'Godzilla',
    rating: "7.3",
    poster_image: AssetsManger.godzilla,
  ),
];

 static final Map<String, List<ReciepeModel>> categories = {
  'Action': [
    featuredReciepes[1],
    featuredReciepes[2],
    featuredReciepes[3],
    featuredReciepes[4],
    featuredReciepes[7],
    featuredReciepes[8],
    featuredReciepes[9],
    featuredReciepes[11],
  ],
  'Drama': [
    featuredReciepes[0],
    featuredReciepes[1],
    featuredReciepes[3],
    featuredReciepes[4],
    featuredReciepes[6],
    featuredReciepes[9],
  ],
  'Sci-Fi': [
    featuredReciepes[0],
    featuredReciepes[2],
    featuredReciepes[3],
    featuredReciepes[4],
    featuredReciepes[10],
    featuredReciepes[11],
  ],
   'Animation':[],
   'Biography':[],
};
static List<String> get labels => categories.keys.toList();

}