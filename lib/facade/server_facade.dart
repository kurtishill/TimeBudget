import 'package:time_budget/facade/base_server_facade.dart';
import 'package:time_budget/facade/services/get_info_for_date_service.dart';

class ServerFacade implements IServerFacade {
  GetInfoForDateService getInfoForDateService;

  ServerFacade() {
    getInfoForDateService = GetInfoForDateService();
  }

  @override
  Future getInfoForDate(DateTime date) async {
    await getInfoForDateService.getInfoForDate(date);
  }
}
