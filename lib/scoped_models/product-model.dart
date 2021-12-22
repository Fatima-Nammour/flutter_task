import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

class ProductModel extends Model {
  List<Product> _products = [];

  set setProducts(List<Product> products) {
    _products = products;
    print('Hi from set products method ');
  }

  List<Product> get products {
    return List.from(_products);
  }

  int? _selectedProductIndex;

  int? get selectedProductIndex {
    if (_selectedProductIndex == null) {
      return null;
    } else
      return _selectedProductIndex!;
  }

  set setSelectedProductIndex(int? index) {
    _selectedProductIndex = index;
  }

  Product? get selectedProduct {
    return _products[_selectedProductIndex!];
  }
}
