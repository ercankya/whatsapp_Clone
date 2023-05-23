import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_clone/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_clone/common/utils/coloors.dart';
import 'package:whatsapp_clone/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clone/feature/contact/controllers/contacts_controller.dart';
import 'package:whatsapp_clone/feature/contact/widgets/contact_card.dart';
import 'package:whatsapp_clone/feature/contact/widgets/other_card.dart';

import '../../../common/modals/user_modal.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  shareSmsLink(phoneNumber) async {
    Uri sms = Uri.parse(
        "sms:${phoneNumber}?body=Lets chat on WhatsApp Clone! It's fast, simple and secure app.We can call each other for free. Get it at https://whatsappClone.com/dl/");
    if (await launchUrl(sms)) {
    } else {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select contact',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 3),
            ref.watch(contactControllerProvider).when(
              data: (allContacts) {
                return Text(
                  "${allContacts[0].length} Contact${allContacts[0].length == 1 ? '' : 's'}",
                  style: const TextStyle(fontSize: 13),
                );
              },
              error: (error, trace) {
                return const SizedBox();
              },
              loading: () {
                return const Text(
                  'counting',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          CustomIconButton(onTop: () {}, icon: Icons.search),
          CustomIconButton(onTop: () {}, icon: Icons.more_vert),
        ],
      ),
      body: ref.watch(contactControllerProvider).when(
            data: (allContacts) {
              return ListView.builder(
                itemCount: allContacts[0].length + allContacts[1].length,
                itemBuilder: (context, index) {
                  late UserModel firebaseContacts;
                  late UserModel phoneContacts;

                  if (index < allContacts[0].length) {
                    firebaseContacts = allContacts[0][index];
                  } else {
                    phoneContacts =
                        allContacts[1][index - allContacts[0].length];
                  }
                  return index < allContacts[0].length
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index == 0)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  OtherListContactCard(
                                      text: 'New Group', leading: Icons.group),
                                  OtherListContactCard(
                                      text: 'New Contact',
                                      leading: Icons.contact_phone,
                                      trailing: Icons.qr_code),
                                  /*myListTile(
                                      leading: Icons.group, text: 'New Group'),
                                  myListTile(
                                      leading: Icons.contact_phone,
                                      text: 'New Contact',
                                      trailing: Icons.qr_code),*/
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      "It's yours",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: context.theme.greyColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ContactCard(
                              contactSource: firebaseContacts,
                              onTap: () {},
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index == allContacts[0].length)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Text(
                                  'Contacts on WhatsApp',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.greyColor,
                                  ),
                                ),
                              ),
                            ContactCard(
                              contactSource: phoneContacts,
                              onTap: () =>
                                  shareSmsLink(phoneContacts.phoneNumber),
                            ),
                          ],
                        );
                },
              );
            },
            error: (error, trace) {},
            loading: () {
              return Center(
                child: CircularProgressIndicator(
                  color: context.theme.authAppBarTextColor,
                ),
              );
            },
          ),
    );
  }
}
