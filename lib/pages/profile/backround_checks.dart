import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cama/providers/provider_auth.dart';
import 'package:cama/shared/flavors.dart';
import 'package:cama/shared/form_kits.dart';
import 'package:cama/shared/imageviewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BackgroundChecks extends StatefulWidget {
  const BackgroundChecks({Key? key}) : super(key: key);

  @override
  State<BackgroundChecks> createState() => _BackgroundChecksState();
}

class _BackgroundChecksState extends State<BackgroundChecks> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = context.watch<AuthProvider>().getUser();
    Map dbs = user!.dbs;

    return Scaffold(
      appBar: AppBar(
        title: Text('Background Checks'),
        actions: [
          IconButton(
            icon:
                Icon((dbs != null) ? Icons.edit_sharp : Icons.add_circle_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'background-checks-edit',
                  arguments: {'dbs': dbs});
            },
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text('Update Service ID'),
                subtitle: (dbs == null)
                    ? Text('----')
                    : Text((dbs['update_service_id'] == null)
                        ? '----'
                        : dbs['update_service_id']),
              ),
              ListTile(
                title: Text('Valid Until'),
                subtitle: (dbs == null)
                    ? Text('----')
                    : Text((dbs['expires_on'] == null)
                        ? '----'
                        : DateFormat('dd-MM-yyyy')
                            .format(DateTime.parse(dbs['expires_on']))),
              ),
              ListTile(
                title: Text('Declaration'),
                subtitle: (dbs == null)
                    ? Text('----')
                    : Text((dbs['declaration'] == null)
                        ? '----'
                        : dbs['declaration']),
              ),
              (dbs != null && dbs['declaration'] == 'Yes')
                  ? Column(
                      children: [
                        Text('Details'),
                        Divider(),
                        Text(
                          dbs['declaration_details'],
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    )
                  : SizedBox(
                      height: 10,
                    ),
              (dbs != null)
                  ? TextButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => ImageViewerPop(
                                  path: (path.extension(dbs['certificate']) ==
                                          '.pdf')
                                      ? 'assets/images/cama-pdf-placeholder.png'
                                      : dbs['certificate'],
                                  isLocal: false,
                                  isAsset:
                                      (path.extension(dbs['certificate']) ==
                                              '.pdf')
                                          ? true
                                          : false,
                                ));
                      },
                      icon: Icon(Icons.image),
                      label: Text('View DBS Image'),
                    )
                  : SizedBox(
                      height: 10,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
