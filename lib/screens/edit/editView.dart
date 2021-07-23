import 'package:cash_analyzer/app/index.dart';

class EditViewPageArguments extends Object {
  final DateTime date;

  EditViewPageArguments(this.date);
}

class EditView extends StatefulWidget {
  static const routeName = '/edit';

  final EditViewPageArguments args;

  const EditView({required this.args, Key? key}) : super(key: key);

  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  double price = 10000;
  TimeOfDay time = TimeOfDay.fromDateTime(DateTime.now().toLocal());

  @override
  void initState() {
    super.initState();
    _controller.value = _controller.value.copyWith(
      text: price.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Cazh Analyzer"),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Material(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '소비 정보를 입력하세요',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '비워둘 수 없습니다!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controller,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return '비워둘 수 없습니다!';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    price = double.parse(_controller.text);
                  },
                ),
                Slider(
                  value: price,
                  min: 0,
                  max: 1000000,
                  divisions: 100000,
                  label: price.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      price = value;
                      _controller.value = _controller.value.copyWith(
                        text: value.toStringAsFixed(0),
                      );
                    });
                  },
                ),
                ElevatedButton(
                  child: Text(time.format(context)),
                  onPressed: () async {
                    TimeOfDay? selected = await showTimePicker(
                        context: context, initialTime: time);
                    setState(() {
                      time = selected != null ? selected : time;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Valitime will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
