enum ProductSort { newest, priceLowHigh, priceHighLow, rating }

class ProductFilterState {
  final String query;
  final ProductSort sort;

  const ProductFilterState({this.query = "", this.sort = ProductSort.newest});

  ProductFilterState copyWith({String? query, ProductSort? sort}) {
    return ProductFilterState(
      query: query ?? this.query,
      sort: sort ?? this.sort,
    );
  }
}
