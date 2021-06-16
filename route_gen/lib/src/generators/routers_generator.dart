import 'package:analyzer/dart/element/element.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:route_gen/src/annotation/routed.dart';
import 'package:route_gen/src/generators/init_routers_generator.dart';
import 'package:source_gen/source_gen.dart';

import 'data.dart';

class RoutersGenerator extends GeneratorForAnnotation<Routed> {


  @override
  generateForAnnotatedElement(
      Element? element, ConstantReader annotation, BuildStep buildStep) {
    if (element == null) return null;
    if (element.kind == ElementKind.CLASS && element.name != null) {
      var className = "${element.name!}";
      var package = buildStep.inputId.package;
      var path = buildStep.inputId.path;
      var importRef = path.replaceAll("lib", package);
      var importResult = "import:\"$importRef\";\n";
      DataGen.listPaths.add(importResult);
      var ref = StringUtils.camelCaseToLowerUnderscore(className);
      if (DataGen.listRefs.contains(ref)) return null;
      DataGen.listRefs.add("\$${className}Generator()");
      return """
import 'package:flutter/material.dart';
import '../../../../app/presentation/router/app_route_generator.dart';
import '${ref}.dart';
          
class \$${className}Generator implements RouteGenerator {
  String routeName = \"$ref\";
  
  @override
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == routeName) {
      return MaterialPageRoute(
          settings: settings, builder: (context) => ${className}());
    }
    return null;
  }
}
      
    """;
    }
    return null;
  }
}
