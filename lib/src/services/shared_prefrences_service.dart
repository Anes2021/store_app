import 'package:shared_preferences/shared_preferences.dart';

// todo: is used to store (List bool int double)
class SharedPrefrencesController {
  //*Keys:
  static const String _favoritesListKey = "favoritesList";

  //*---------------------------------------------------------------------------*//

  //* read daily conversations
  Future<List<String>> readFavoritesList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //* / Default Value
    if (prefs.getStringList(_favoritesListKey) == null) {
      await prefs.setStringList(_favoritesListKey, []);
      return [];
    }
    return prefs.getStringList(_favoritesListKey)!;
  }

  //* write daily conversations
  Future<bool> writeFavorites(List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(_favoritesListKey, value);
  }

  //*---------------------------------------------------------------------------*//

  //* clear all
  Future<bool> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
