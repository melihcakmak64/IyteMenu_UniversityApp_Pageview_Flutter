import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class NetworkController {
  static Future<List<String>> readMenu(String type, {String? tarih}) async {
    try {
      tarih ??= datetimeToString(DateTime.now());
      var url =
          "https://yks.iyte.edu.tr/yemekliste.aspx?tarih=$tarih&ogun=$type";
      var response = await http.get(Uri.parse(url));

      try {
        var document = parse(response.body);
        var yemek_tablosu = document.getElementById('GridView1');

        List<String> yemek_listesi = [];

        yemek_tablosu!.querySelectorAll('tr').skip(1).forEach((row) {
          var hucreler = row.querySelectorAll('td');
          String yemek_adi = hucreler[0].text;

          yemek_listesi.add(yemek_adi);
        });

        return yemek_listesi;
      } catch (e) {
        return ["Tatil Günündesiniz"];
      }
    } catch (e) {
      // Handle any other exceptions that might occur

      return ["İnternet Bağlantınızı Kontrol Ediniz"];
    }
  }

  static String datetimeToString(DateTime time) {
    String month = time.month < 10 ? '0${time.month}' : '${time.month}';
    String day = time.day < 10 ? '0${time.day}' : '${time.day}';
    String year = '${time.year}';

    String date = "$month.$day.$year";
    return date;
  }
}
