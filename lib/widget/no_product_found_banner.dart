import 'package:flutter/material.dart';
import 'package:mekto/services/http_services.dart';
import 'package:mekto/utility/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class NoProductFoundBanner extends StatelessWidget {
  final VoidCallback onClose;
  const NoProductFoundBanner({super.key, required this.onClose});
  @override
  Widget build(BuildContext context) {
    HttpService service = HttpService();

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColor.branco,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.cinzaDavys)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Não encontrou a peça que procura?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.pretoAssombroso),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Clique no botão abaixo e nossa equipe vai te ajudar a encontrá-la!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.pretoAssombroso),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.halloween,
                ),
                onPressed: () async {
                  String phoneNumber = await service.getPhoneNumber();
                  phoneNumber = phoneNumber == "" ? "123" : phoneNumber;
                  final url = Uri.parse(
                      'https://wa.me/$phoneNumber?text=Olá!%20Gostaria%20de%20ajuda%20para%20encontrar%20uma%20peça.');

                  final fallbackUrl = Uri.parse(
                      'https://api.whatsapp.com/send?phone=$phoneNumber&text=Olá!%20Gostaria%20de%20ajuda%20para%20encontrar%20uma%20peça.');

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else if (await canLaunchUrl(fallbackUrl)) {
                    await launchUrl(fallbackUrl,
                        mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Não foi possível abrir o WhatsApp.')),
                    );
                  }
                },
                child: const Text(
                  "Encontrar minha peça",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose,
          ),
        ),
      ],
    );
  }
}
