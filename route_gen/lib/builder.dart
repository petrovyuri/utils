import 'package:build/build.dart';
import 'package:route_gen/src/generators/init_routers_generator.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/routers_generator.dart';

Builder generateRouters(BuilderOptions options) =>
    LibraryBuilder(RoutersGenerator(), generatedExtension: '.gen.dart');

Builder initRoutes(BuilderOptions options) =>
    LibraryBuilder(InitGenerator(), generatedExtension: '.init.dart');
