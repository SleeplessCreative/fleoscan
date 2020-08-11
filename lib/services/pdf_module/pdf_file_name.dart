class FileName {
  final DateTime current = DateTime.now();

  String getFileName(String flightNumber) {
    String fileExt = '.pdf';
    String _y = current.year.toString();
    String _mo = reFormat(current.month.toString());
    String _d = reFormat(current.day.toString());
    String _h = reFormat(current.hour.toString());
    String _mi = reFormat(current.minute.toString());
    String _s = reFormat(current.second.toString());
    String fileName = '/' +
        _y +
        _mo +
        _d +
        '-' +
        _h +
        _mi +
        _s +
        '-' +
        flightNumber +
        fileExt;
    return fileName;
  }

  String reFormat(String S) {
    while (S.length < 2) {
      S = '0' + S;
    }
    return S;
  }
}
