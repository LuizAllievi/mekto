import '../../utility/extensions.dart';
import 'package:flutter/material.dart';
import '../../utility/app_color.dart';
import '../../widget/custom_text_field.dart';

class MyAddressPage extends StatelessWidget {
  const MyAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.profileProvider.retrieveSavedAddress();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meu Endereço",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.darkOrange),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: context.profileProvider.addressFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    surfaceTintColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            labelText: 'Celular',
                            onSave: (value) {},
                            inputType: TextInputType.number,
                            controller: context.profileProvider.phoneController,
                            validator: (value) => value!.isEmpty ? 'Por favor, digite um número de celular' : null,
                          ),
                          CustomTextField(
                            labelText: 'Rua',
                            onSave: (val) {},
                            controller: context.profileProvider.streetController,
                            validator: (value) => value!.isEmpty ? 'Por favor, digite a rua' : null,
                          ),
                          CustomTextField(
                            labelText: 'Cidade',
                            onSave: (value) {},
                            controller: context.profileProvider.cityController,
                            validator: (value) => value!.isEmpty ? 'Por favor, digite a cidade' : null,
                          ),
                          CustomTextField(
                            labelText: 'Estado',
                            onSave: (value) {},
                            controller: context.profileProvider.stateController,
                            validator: (value) => value!.isEmpty ? 'Por favor, digite o estado' : null,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  labelText: 'CEP',
                                  onSave: (value) {},
                                  inputType: TextInputType.number,
                                  controller: context.profileProvider.postalCodeController,
                                  validator: (value) => value!.isEmpty ? 'Por favor, digite o CEP' : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  labelText: 'País',
                                  onSave: (value) {},
                                  controller: context.profileProvider.countryController,
                                  validator: (value) => value!.isEmpty ? 'Por favor, digite o país ' : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.darkOrange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        if (context.profileProvider.addressFormKey.currentState!.validate()) {
                          context.profileProvider.storeAddress();
                        }
                      },
                      child: const Text('Atualizar Endereço', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
