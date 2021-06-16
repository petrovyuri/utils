import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:route_gen/src/annotation/route_gen_init.dart';
import 'package:route_gen/src/generators/data.dart';
import 'package:route_gen/src/generators/routers_generator.dart';
import 'package:source_gen/source_gen.dart';


class InitGenerator extends GeneratorForAnnotation<RouteGenInit> {



  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return resultClass(DataGen.listRefs);
  }
}

String resultClass(List list) {
  return """
import 'package:app_logger/app_logger.dart';
import 'package:flutter/material.dart';

${
      DataGen.listPaths.map((e) => "$e")
  }

import 'app_route_generator.dart';

class \$AppRouteGenerator extends RouteGenerator {
  final generators = ${list ?? []};

  Route? onGenerateRoute(RouteSettings settings) {
    logJust(
      settings.name,
      tag: "onGenerateRoute",
    );
    for (var element in generators) {
      final route = element.onGenerateRoute(settings);
      if (route != null) {
        return route;
      }
    }
    return null;
  }
}
  
  
  """;
}
