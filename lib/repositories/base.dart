import 'package:getx_example/models/folder.dart';
import 'package:getx_example/constants.dart';


abstract class BaseRepository {

  String getKey(String name, List<Folder> path) {
    if (path != null && path.isNotEmpty) {
      return pathSeparator + path.join(pathSeparator) + pathSeparator + name;
    } else {
      return pathSeparator + name;
    }
  }
}