import 'package:bare_bones/application/auth/phone_number_sign_in/phone_number_sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberForm extends StatefulWidget {
  final Key formKey;
  final void Function(String?) onInputChanged;

  const PhoneNumberForm({
    required this.formKey,
    required this.onInputChanged,
  });

  @override
  _PhoneNumberFormState createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  final PhoneNumber initialPhone = PhoneNumber(isoCode: "US");

  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void didChangeDependencies() {
    context
        .read<PhoneNumberSignInCubit>()
        .phoneNumberChanged(phoneNumber: initialPhone.phoneNumber ?? "");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                "Phone Number",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          InternationalPhoneNumberInput(
      
            onInputChanged: (s) => widget.onInputChanged(s.phoneNumber),
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
            ),
            autoFocus: true,
            selectorTextStyle: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            textStyle: const TextStyle(color: Colors.white),
            initialValue: initialPhone,
            textFieldController: phoneNumberController,
            formatInput: false,
            inputDecoration: const InputDecoration(
              hintText: "Phone Number",
              hintStyle: TextStyle(color: Colors.white),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
