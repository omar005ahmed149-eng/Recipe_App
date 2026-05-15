class Categories {
  Categories({
      String? idCategory, 
      String? strCategory, 
      String? strCategoryThumb, 
      String? strCategoryDescription,}){
    _idCategory = idCategory;
    _strCategory = strCategory;
    _strCategoryThumb = strCategoryThumb;
    _strCategoryDescription = strCategoryDescription;
}

  Categories.fromJson(dynamic json) {
    _idCategory = json['idCategory'];
    _strCategory = json['strCategory'];
    _strCategoryThumb = json['strCategoryThumb'];
    _strCategoryDescription = json['strCategoryDescription'];
  }
  String? _idCategory;
  String? _strCategory;
  String? _strCategoryThumb;
  String? _strCategoryDescription;

  String? get idCategory => _idCategory;
  String? get strCategory => _strCategory;
  String? get strCategoryThumb => _strCategoryThumb;
  String? get strCategoryDescription => _strCategoryDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idCategory'] = _idCategory;
    map['strCategory'] = _strCategory;
    map['strCategoryThumb'] = _strCategoryThumb;
    map['strCategoryDescription'] = _strCategoryDescription;
    return map;
  }
  @override
  String toString() {
    return 'Categories(id: $_idCategory, name: $_strCategory, thumb: $_strCategoryThumb)';
  }

}