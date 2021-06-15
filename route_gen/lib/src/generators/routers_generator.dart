import 'package:analyzer/dart/element/element.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:route_gen/src/annotation/routed.dart';
import 'package:source_gen/source_gen.dart';

class RoutersGenerator extends GeneratorForAnnotation<Routed> {
  static List<String> listRefs = [];

  @override
  generateForAnnotatedElement(
      Element? element, ConstantReader annotation, BuildStep buildStep) {
    if (element == null) return null;
    if (element.kind == ElementKind.CLASS && element.name != null) {
      var className = "${element.name!}";
      var ref = StringUtils.camelCaseToLowerUnderscore(className);
      if (listRefs.contains(ref)) return null;
      listRefs.add("\$${className}Generator()");
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

