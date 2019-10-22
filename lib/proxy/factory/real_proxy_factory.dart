import 'package:flutter/foundation.dart';
import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/base_proxy_factory.dart';

import '../real_proxy.dart';

class RealProxyFactory implements IProxyFactory {
  final String ip;
  final String port;

  RealProxyFactory({
    @required this.ip,
    this.port = '8080',
  });

  @override
  IProxy get proxy => RealProxy(ip: this.ip, port: this.port);
}
