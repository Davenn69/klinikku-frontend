//TODO uncomment files
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.stage')
abstract class EnvStage {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvStage.baseUrl;
  @EnviedField(varName: 'SHOW_BANNER')
  static const bool showBanner = _EnvStage.showBanner;
}

@Envied(path: '.env.prod')
abstract class EnvProd {
  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _EnvProd.baseUrl;
  @EnviedField(varName: 'SHOW_BANNER')
  static const bool showBanner = _EnvProd.showBanner;
}
