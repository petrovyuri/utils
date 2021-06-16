import 'package:analyzer/dart/element/element.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:route_gen/src/annotation/routed.dart';
import 'package:route_gen/src/generators/init_routers_generator.dart';
import 'package:source_gen/source_gen.dart';

import '../data.dart';

class RoutersGenerator extends GeneratorForAnnotation<Routed> {
  @override
  generateForAnnotatedElement(
      Element? element, ConstantReader annotation, BuildStep buildStep) {
    if (element == null) return null;
    if (element.kind == ElementKind.CLASS && element.name != null) {
      var routeAnnotation = annotation.peek("route")!.stringValue;
      if(routeAnnotation.isNotEmpty){
        // Что то сделать.
      }
      var className = "${element.name!}";
      var underScoreName = StringUtils.camelCaseToLowerUnderscore(className);
      var generatorName = "\$${className}Generator()";
      var pathSource = buildStep.inputId.path;
      var pathResult = pathSource.replaceAll("lib", "../../..");
      var importResult = "import \"$pathResult\";\n";
      DataGen.listImports.add(importResult);
      DataGen.listGenerators.add(generatorName);
      DataGen.listRoutes.add(
          """
          
class \$${className}Generator implements RouteGenerator {
  String routeName = \"$underScoreName\";
  
  @override
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == routeName) {
      return MaterialPageRoute(
          settings: settings, builder: (context) => ${className}());
    }
    return null;
  }
}
"""
      );
      return null;
    }
    return null;
  }
}


