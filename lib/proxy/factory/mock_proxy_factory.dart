import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/base_proxy_factory.dart';
import 'package:time_budget/proxy/mock_proxy.dart';

class MockProxyFactory implements IProxyFactory {
  @override
  IProxy get proxy => MockProxy();
}
