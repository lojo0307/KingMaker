import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/widget/routine/regist_routine.dart';
import 'package:kingmaker/widget/todo/regist_todo.dart';

class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return (flag)
        ? GestureDetector(
            onTap: () {
              flag = false;
              setState(() {});
            },
            child: Scaffold(
              backgroundColor: Colors.black.withOpacity(0.5),
              body: addPage(),
            ),
          )
        : addPage();
  }

  Widget addPage() {
    return Column(
      children: [
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              (flag)
                  ? Container(
                      margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                      ),
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          flag = !flag;
                          setState(() {});
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistTodo()));
                        },
                        child: const Text(
                          '할일 등록하기',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              (flag)
                  ? Container(
                      margin: const EdgeInsetsDirectional.symmetric(
                        horizontal: 10,
                      ),
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          flag = !flag;
                          setState(() {});
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistRoutine()));
                        },
                        child: const Text(
                          '루틴 등록하기',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              TextButton(
                onPressed: () {
                  flag = !flag;
                  setState(() {});
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: const Color(0xFF9FC6D2),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white)),
                  child: const Icon(
                    CupertinoIcons.plus,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
