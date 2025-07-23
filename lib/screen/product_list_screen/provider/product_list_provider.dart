import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/connect.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/product.dart';
import '../../../services/http_services.dart';
import '../../../utility/constants.dart';

class ProductListProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  int _page = 0;
  bool _quering = false;
  String _queryText = '';
  ProductListProvider(this._dataProvider);

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _allProducts;

  emptyProducts() {
    _page = 0;
    _allProducts = [];

    return;
  }

  setQuering(bool status) {
    _quering = status;

    return;
  }

  bool isQuering() {
    return _quering;
  }

  String getQueryText() {
    return _queryText;
  }

  String setQueryText(String queryText) {
    return _queryText = queryText;
  }

  getProducts() async {
    await this._dataProvider.getProductsPagination(page: _page).then((data) {
      print(data);
      _allProducts.addAll(data);
    });
    print(_page);
    _page++;
    notifyListeners();
  }

  bool _endOfResults = false;

  bool getEndOfResults() {
    return _endOfResults;
  }

  getProductsByQuery(String query) async {
    _endOfResults = false;
    _queryText = query;
    final data = await _dataProvider.getProductsPaginationByQuery(
        page: _page, query: query);

    if (data.isEmpty) {
      // Não veio mais produto, chegou no fim
      _endOfResults = true;
      // Aqui você pode notificar o listener para mostrar o banner
      notifyListeners();
    } else {
      _allProducts.addAll(data);
      _page++;
      notifyListeners();
    }
  }

  getFavoriteProducts(List<String> ids) async {
    await this
        ._dataProvider
        .getFavoriteProducts(ids: ids, page: _page)
        .then((data) {
      print("FAVO" + data.toString());
      _allProducts.addAll(data);
    });
    print(_page);
    _page++;
    notifyListeners();
  }
}
