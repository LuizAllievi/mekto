import '../../../models/brand.dart';
import '../../../models/category.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';

class ProductByCategoryProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  Category? mySelectedCategory;
  SubCategory? mySelectedSubCategory;
  List<SubCategory> subCategories = [];
  List<Brand> brands = [];
  List<Brand> selectedBrands = [];
  List<Product> filteredProduct = [];

  ProductByCategoryProvider(this._dataProvider);

  filterInitialProductAndSubCategory(Category selectedCategory){
    mySelectedSubCategory = SubCategory(name: "Todas");
    mySelectedCategory = selectedCategory;
    subCategories =
        _dataProvider.subCategories.where((subCategory) => subCategory.categoryId?.sId == selectedCategory.sId).toList();
    subCategories.insert(0, SubCategory(name: "Todas"));
    filteredProduct =
        _dataProvider.products.where((product) => product.proCategoryId?.name == selectedCategory.name).toList();
    notifyListeners();
  }

  filterProductBySubCategory(SubCategory subCategory){
    mySelectedSubCategory = subCategory;
    if (subCategory.name == "Todas"){
      filteredProduct =
          _dataProvider.products.where((product) => product.proCategoryId?.name == mySelectedCategory?.name).toList();
      brands = [];
    } else {
      filteredProduct =
          _dataProvider.products.where((product) =>
          product.proSubCategoryId?.name == subCategory.name).toList();
      brands = _dataProvider.brands.where((brand) => brand.subcategory?.sId == subCategory.sId).toList();
    }
    notifyListeners();
  }


  filterProductByBrand(){
    if (selectedBrands.isEmpty){
      filteredProduct =
          _dataProvider.products.where((product) => product.proCategoryId?.name == mySelectedCategory?.name).toList();
    } else {
      filteredProduct =
          _dataProvider.products.where((product) =>
          product.proSubCategoryId?.name == mySelectedSubCategory?.name &&
          selectedBrands.any((brand) => product.proBrandId?.sId == brand.sId)).toList();
    }
    notifyListeners();
  }

  void sortProducts({required bool ascending}){
    filteredProduct.sort((a, b) {
      if (ascending){
        return a.price!.compareTo(b.price ?? 0);
      } else {
        return b.price!.compareTo(a.price ?? 0);
      }
    });
    notifyListeners();
  }


  void updateUI() {
    notifyListeners();
  }
}
