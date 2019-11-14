import 'package:flutter/material.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/state/app_state.dart';

class GetActiveCategoriesService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future getActiveCategories(String token) async {
    final response = await _proxy.getActiveCategories(token);

    if (response != null) {
      List<Category> categories = [];
      response.categories.forEach(
        (c) {
          categories.add(
            Category(
              id: c.categoryID,
              name: c.description,
              events: [],
              color: Color(c.color),
            ),
          );
        },
      );

      AppState().setActiveCategories(categories);
    }
    return null;
  }
}
