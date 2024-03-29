// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/airlines_service.dart';
import '../services/airports_service.dart';
import '../services/analytics_service.dart';
import '../services/pdf_create_services.dart';
import '../services/database_service.dart';
import '../services/device_info_services.dart';
import '../services/scan_service.dart';
import '../services/pdf_storage_permission_service.dart';
import '../services/third_party_services_module.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<AirlinesService>(() => AirlinesService());
  gh.lazySingleton<AirportsService>(() => AirportsService());
  gh.lazySingleton<AnalyticsService>(() => AnalyticsService());
  gh.lazySingleton<CreatePdfService>(() => CreatePdfService());
  gh.lazySingleton<DatabaseService>(() => DatabaseService());
  gh.lazySingleton<DeviceInfoService>(() => DeviceInfoService());
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<ScanService>(() => ScanService());
  gh.lazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
  gh.lazySingleton<StoragePermission>(() => StoragePermission());
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
