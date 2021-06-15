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
    var visitor = ModelVisitor();
    element.visitChildren(visitor);
    var isRoot = visitor.mapFields["isRoot"];

    if (element.kind == ElementKind.CLASS && element.name != null) {
      var className = "${element.name!}";
      var ref = StringUtils.camelCaseToLowerUnderscore(className);
      if (listRefs.contains(ref)) return null;
      listRefs.add(
          "\$${className}Generator(isRoot: $isRoot)");
      return """
import 'package:flutter/material.dart';
import '../../../../app/presentation/router/app_route_generator.dart';
import '${ref}.dart';
          
class \$${className}Generator implements RouteGenerator {
  String routeName = \"$ref\";
  bool? isRoot = $isRoot;
  
  \$FeedbackScreenGenerator({this.isRoot});
  
  @override
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == routeName) {
      return MaterialPageRoute(
          settings: settings, builder: (context) => ${className}(isRoot:$isRoot));
    }
    return null;
  }
}
      
    """;
    }

    return null;
  }
}

class ModelVisitor extends ElementVisitor {
  Map<String, dynamic> mapFields = Map();

  @override
  visitClassElement(ClassElement element) {
    // TODO: implement visitClassElement
    throw UnimplementedError();
  }

  @override
  visitCompilationUnitElement(CompilationUnitElement element) {
    // TODO: implement visitCompilationUnitElement
    throw UnimplementedError();
  }

  @override
  visitConstructorElement(ConstructorElement element) {}

  @override
  visitExportElement(ExportElement element) {
    // TODO: implement visitExportElement
    throw UnimplementedError();
  }

  @override
  visitExtensionElement(ExtensionElement element) {
    // TODO: implement visitExtensionElement
    throw UnimplementedError();
  }

  @override
  visitFieldElement(FieldElement element) {
    mapFields[element.name] = element.type;
  }

  @override
  visitFieldFormalParameterElement(FieldFormalParameterElement element) {
    // TODO: implement visitFieldFormalParameterElement
    throw UnimplementedError();
  }

  @override
  visitFunctionElement(FunctionElement element) {
    // TODO: implement visitFunctionElement
    throw UnimplementedError();
  }

  @override
  visitFunctionTypeAliasElement(FunctionTypeAliasElement element) {
    // TODO: implement visitFunctionTypeAliasElement
    throw UnimplementedError();
  }

  @override
  visitGenericFunctionTypeElement(GenericFunctionTypeElement element) {
    // TODO: implement visitGenericFunctionTypeElement
    throw UnimplementedError();
  }

  @override
  visitImportElement(ImportElement element) {
    // TODO: implement visitImportElement
    throw UnimplementedError();
  }

  @override
  visitLabelElement(LabelElement element) {
    // TODO: implement visitLabelElement
    throw UnimplementedError();
  }

  @override
  visitLibraryElement(LibraryElement element) {
    // TODO: implement visitLibraryElement
    throw UnimplementedError();
  }

  @override
  visitLocalVariableElement(LocalVariableElement element) {
    // TODO: implement visitLocalVariableElement
    throw UnimplementedError();
  }

  @override
  visitMethodElement(MethodElement element) {
    // TODO: implement visitMethodElement
    throw UnimplementedError();
  }

  @override
  visitMultiplyDefinedElement(MultiplyDefinedElement element) {
    // TODO: implement visitMultiplyDefinedElement
    throw UnimplementedError();
  }

  @override
  visitParameterElement(ParameterElement element) {
    // TODO: implement visitParameterElement
    throw UnimplementedError();
  }

  @override
  visitPrefixElement(PrefixElement element) {
    // TODO: implement visitPrefixElement
    throw UnimplementedError();
  }

  @override
  visitPropertyAccessorElement(PropertyAccessorElement element) {
    // TODO: implement visitPropertyAccessorElement
    throw UnimplementedError();
  }

  @override
  visitTopLevelVariableElement(TopLevelVariableElement element) {
    // TODO: implement visitTopLevelVariableElement
    throw UnimplementedError();
  }

  @override
  visitTypeAliasElement(TypeAliasElement element) {
    // TODO: implement visitTypeAliasElement
    throw UnimplementedError();
  }

  @override
  visitTypeParameterElement(TypeParameterElement element) {
    // TODO: implement visitTypeParameterElement
    throw UnimplementedError();
  }
}
