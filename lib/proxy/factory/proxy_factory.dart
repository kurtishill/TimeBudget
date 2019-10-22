import 'package:time_budget/proxy/factory/base_proxy_factory.dart';

import '../base_proxy.dart';

class ProxyFactory {
  static IProxyFactory _instance;

  static void configure(IProxyFactory proxyFactory) {
    _instance = proxyFactory;
  }

  static IProxy get proxy => _instance.proxy;
}
