import 'package:models/model.dart';
import 'package:services/database.dart';
import 'package:services/datamodels/dbform.dart';

class FormRepo {
  Future<void> addForm(FormModel form) async {
    await DBProvider.db.addForm(DBForm(
      username: form.username,
      question: form.question,
    ));
  }
}