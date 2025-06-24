import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/category.dart';
import '../../models/api_response.dart';
import '../../models/brand.dart';
import '../../models/order.dart';
import '../../models/poster.dart';
import '../../models/product.dart';
import '../../models/sub_category.dart';
import '../../models/user.dart';
import '../../services/http_services.dart';
import '../../utility/constants.dart';
import '../../utility/snack_bar_helper.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];

  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;
  List<Product> get allProducts => _allProducts;

  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  DataProvider() {
    getAllCategory();
    getAllSubCategory();
    getAllBrands();
    getAllPosters();
  }

  Future<List<Category>> getAllCategory({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'api/categories');
      if (response.isOk) {
        _allCategories = (response.body['content'] as List)
            .map((item) => Category.fromJson(item))
            .toList();
        _filteredCategories =
            List.from(_allCategories); // Initialize filtered list with all data
        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(
              "Categorias carregadas com sucesso");
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
      rethrow;
    }
    return _filteredCategories;
  }

  void filterCategories(String keyword) {
    if (keyword.isEmpty) {
      _filteredCategories = List.from(_allCategories);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredCategories = _allCategories.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<SubCategory>> getAllSubCategory({bool showSnack = false}) async {
    try {
      Response response =
          await service.getItems(endpointUrl: 'api/subCategories');
      if (response.isOk) {
        _allSubCategories = (response.body as List)
            .map((item) => SubCategory.fromJson(item))
            .toList();
        _filteredSubCategories = List.from(
            _allSubCategories); // Initialize filtered list with all data
        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar(
              "SubCategorias carregadas com sucesso");
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
      rethrow;
    }
    return _filteredSubCategories;
  }

  void filterSubCategories(String keyword) {
    if (keyword.isEmpty) {
      _filteredSubCategories = List.from(_allSubCategories);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredSubCategories = _allSubCategories.where((subCategory) {
        return (subCategory.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Brand>> getAllBrands({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'api/brands');
      if (response.isOk) {
        _allBrands = (response.body as List)
            .map((item) => Brand.fromJson(item))
            .toList();
        _filteredBrands =
            List.from(_allBrands); // Initialize filtered list with all data
        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar("Marcas carregadas com sucesso!");
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
      rethrow;
    }
    return _filteredBrands;
  }

  void filterBrands(String keyword) {
    if (keyword.isEmpty) {
      _filteredBrands = List.from(_allBrands);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((brand) {
        return (brand.name ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Poster>> getAllPosters({bool showSnack = false}) async {
    try {
      Response response =
          await service.getWithoutAuth(endpointUrl: 'api/posters');
      if (response.isOk) {
        _allPosters = (response.body as List)
            .map((item) => Poster.fromJson(item))
            .toList();
        _filteredPosters =
            List.from(_allPosters); // Initialize filtered list with all data
        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar("Posters carregados com sucesso");
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
      rethrow;
    }
    return _filteredPosters;
  }

  void filterPosters(String keyword) {
    if (keyword.isEmpty) {
      _filteredPosters = List.from(_allPosters);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredPosters = _allPosters.where((poster) {
        return (poster.posterName ?? '').toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  Future<List<Product>> getProductsPaginationByQuery(
      {bool showSnack = false, int page = 0, String query = ''}) async {
    try {
      Response response = await service.getWithoutAuth(
          endpointUrl: 'api/products/search/' +
              query +
              '?size=6&page=' +
              page.toString());
      if (response.isOk) {
        if (response.body['content'] != '') {
          return (response.body['content'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
        }

        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar("Produtos carregados com sucesso");
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
      rethrow;
    }
    throw Exception();
  }

  Future<List<Product>> getProductsPagination(
      {bool showSnack = false, int page = 0}) async {
    try {
      Response response = await service.getWithoutAuth(
          endpointUrl: 'api/products?size=6&page=' + page.toString());
      if (response.isOk) {
        if (response.body['content'] != '') {
          print("carregou produtos certo");
          return (response.body['content'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
        }

        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar("Produtos carregados com sucesso");
        }
      } else {
        print("erro carregar produtos " + response.body);
      }
    } catch (e) {
      print(e);
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
      rethrow;
    }
    throw Exception();
  }

  Future<List<Product>> getFavoriteProducts(
      {bool showSnack = false,
      List<String> ids = const [],
      int page = 0}) async {
    try {
      print('api/products/byIdList/' +
          ids
              .toString()
              .replaceAll("[", '')
              .replaceAll(']', '')
              .replaceAll(" ", ''));
      Response response = await service.getItems(
          endpointUrl: 'api/products/byIdList/' +
              ids.toString().replaceAll("[", '').replaceAll(']', '') +
              "?size=6&page=" +
              page.toString());
      if (response.isOk) {
        if (response.body['content'] != '') {
          return (response.body['content'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
        }

        notifyListeners();
        if (showSnack) {
          SnackBarHelper.showSuccessSnackBar("Produtos carregados com sucesso");
        }
      }
    } catch (e) {
      if (showSnack) {
        SnackBarHelper.showErrorSnackBar(e.toString());
      }
      rethrow;
    }
    throw Exception();
  }

  void filterProducts(String keyword) {
    if (keyword.isEmpty) {
      _filteredProducts = List.from(_allProducts);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredProducts = _allProducts.where((product) {
        final productNameContainsKeyword =
            (product.name ?? '').toLowerCase().contains(lowerKeyword);
        final categoryNameContainsKeyword =
            product.proCategoryId?.name?.toLowerCase().contains(lowerKeyword) ??
                false;
        final subCategoryNameContainsKeyword = product.proSubCategoryId?.name
                ?.toLowerCase()
                .contains(lowerKeyword) ??
            false;

        return productNameContainsKeyword ||
            categoryNameContainsKeyword ||
            subCategoryNameContainsKeyword;
      }).toList();
    }
    notifyListeners();
  }

  getAllOrderByUser() async {
    try {
      Response response = await service.getItems(endpointUrl: "api/orders");
      if (response.isOk) {
        final orders = (response.body as List)
            .map((item) => Order.fromJson(item))
            .toList();
        _allOrders = orders;
        _filteredOrders = List.from(_allOrders);

        notifyListeners();
      } else
        SnackBarHelper.showErrorSnackBar("Erro ao buscar pedidos!");
    } catch (e) {
      SnackBarHelper.showErrorSnackBar("Erro 1 ao buscar pedidos!");
    }
    return _filteredOrders;
  }

  double calculateDiscountPercentage(num originalPrice, num? discountedPrice) {
    if (originalPrice <= 0) {
      throw ArgumentError('Original price must be greater than zero.');
    }

    //? Ensure discountedPrice is not null; if it is, default to the original price (no discount)
    num finalDiscountedPrice = discountedPrice ?? originalPrice;

    if (finalDiscountedPrice > originalPrice) {
      return originalPrice.toDouble();
    }

    double discount =
        ((originalPrice - finalDiscountedPrice) / originalPrice) * 100;

    //? Return the discount percentage as an integer
    return discount;
  }
}
