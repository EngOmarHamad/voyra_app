class AddressModel {
  final String id;
  final String title;
  final String details;
  final String type; // 'home', 'work', 'other'

  AddressModel({
    required this.id,
    required this.title,
    required this.details,
    required this.type,
  });
}
