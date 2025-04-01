/// ISuspension Bean.
abstract class ISuspensionBean {
  bool isShowSuspension = false;

  String getSuspensionTag(); //Suspension Tag
}

/// Suspension Util.
class SuspensionUtil {
  /// sort list by suspension tag.
  /// 根据[A-Z]排序。
  static void sortListBySuspensionTag(List<ISuspensionBean>? list) {
  if (list == null || list.isEmpty) return;
  list.sort((a, b) {
    String tagA = a.getSuspensionTag();
    String tagB = b.getSuspensionTag();

    // Check if tags are numeric
    bool isTagANumeric = double.tryParse(tagA) != null;
    bool isTagBNumeric = double.tryParse(tagB) != null;

    if (isTagANumeric && !isTagBNumeric) {
      return -1; // Numbers come before alphabets
    } else if (!isTagANumeric && isTagBNumeric) {
      return 1; // Alphabets come after numbers
    } else if (isTagANumeric && isTagBNumeric) {
      return double.parse(tagA).compareTo(double.parse(tagB)); // Compare numbers
    } else {
      // Handle special cases for "@" and "#"
      if (tagA == "@" || tagB == "#") {
        return -1;
      } else if (tagA == "#" || tagB == "@") {
        return 1;
      } else {
        return tagA.compareTo(tagB); // Compare alphabetically
      }
    }
  });
}

  /// get index data list by suspension tag.
  /// 获取索引列表。
  static List<String> getTagIndexList(List<ISuspensionBean>? list) {
    List<String> indexData = [];
    if (list != null && list.isNotEmpty) {
      String? tempTag;
      for (int i = 0, length = list.length; i < length; i++) {
        String tag = list[i].getSuspensionTag();
        if (tempTag != tag) {
          indexData.add(tag);
          tempTag = tag;
        }
      }
    }
    return indexData;
  }

  /// set show suspension status.
  /// 设置显示悬停Header状态。
  static void setShowSuspensionStatus(List<ISuspensionBean>? list) {
    if (list == null || list.isEmpty) return;
    String? tempTag;
    for (int i = 0, length = list.length; i < length; i++) {
      String tag = list[i].getSuspensionTag();
      if (tempTag != tag) {
        tempTag = tag;
        list[i].isShowSuspension = true;
      } else {
        list[i].isShowSuspension = false;
      }
    }
  }
}
