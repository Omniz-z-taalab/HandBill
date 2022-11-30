// void _onScroll() {
//   final max = _scrollController!.position.maxScrollExtent;
//   final offset = _scrollController!.offset;
//   if (offset + offsetVisibleThreshold >= max && !_categoryBloc!.isFetching) {
//     _categoryBloc!.isFetching = true;
//     if (_selectedCategory == null)
//       _selectedCategory = _categoryBloc!.categories!.first;
//     if (_showRealLength == false)
//       setState(() {
//         _showRealLength = true;
//       });
//     Timer(Duration(seconds: 6), () {
//       _categoryBloc!.add(FetchSubCategoriesEvent(
//           categoryId: _selectedCategory!.id.toString()));
//     });
//   }
// }