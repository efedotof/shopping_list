
import 'package:flutter/material.dart';
import 'package:spisok_pokupok/features/info/bloc/info_bloc_bloc.dart';


class SignInOptionsScreen extends StatefulWidget {
  const SignInOptionsScreen({super.key, required this.bloc});

  final InfoBlocBloc bloc;

  @override
  State<SignInOptionsScreen> createState() => _SignInOptionsScreenState();
}

class _SignInOptionsScreenState extends State<SignInOptionsScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Новый список',
                  style: TextStyle(
                      color: Color(0xFF252E8F),
                      fontWeight: FontWeight.normal,
                      fontSize: 22),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01,
                    horizontal: MediaQuery.of(context).size.width * 0.01,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: TextField(
                    maxLines: 1,
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {
                        _controller.text = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Как назовем ?',
                      prefixIcon: Icon(Icons.add),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => widget.bloc.add(NextScreenAdd(
                    context: context,
                    title: _controller.text,
                    bloc: widget.bloc,
                  )),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF5D5FF0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: const Text(
                      'Создать',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
