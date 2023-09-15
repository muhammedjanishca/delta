import 'dart:html';
import 'dart:typed_data';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final blob = Blob([Uint8List.fromList(bytes)]);
  final url = Url.createObjectUrlFromBlob(blob);
  AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();
  Url.revokeObjectUrl(url);
}