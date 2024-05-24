import 'package:uuid/uuid.dart';

enum ExpenseCategory{
  food('Food'),
  shopping('Shopping'),
  travel('Travel');

  const ExpenseCategory(this.name);
  final String name;

}

String generateUuid({required String code}) {
  Uuid uuid = const Uuid();
  return '$code-${uuid.v4()}';
}
