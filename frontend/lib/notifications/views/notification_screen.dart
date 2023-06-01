import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/UI/common/loading_paragraph.dart';
import '../../Theme/theme.dart';
import '../notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<ThemeBloc>().state.theme,
      home: BlocProvider<NotificationBloc>(
        create: (context) => NotificationBloc()..add(NotificationLoadEvent()),
        child: Scaffold(
          // a back button to pop back of the context

          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text("Notifications"),
          ),
          body: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationsLoading) {
                return const LoadingParagraphWidget(numberOfLines: 3);
              } else if (state is NotificationsLoadedSuccess) {
                return ListView.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return Dismissible(
                      key: Key(notification.id.toString()),
                      onDismissed: (direction) {
                        BlocProvider.of<NotificationBloc>(context).add(
                          NotificationMarkAsDoneEvent(
                              notification: notification),
                        );
                      },
                      // an expandable tile
                      child: ExpansionTile(
                        title: Text(notification.message),
                        subtitle: const Text("03-03-2021"),
                        // subtitle: Text(notification.createdAt.toString()),
                        children: [
                          Text(notification.message),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is NotificationsLoadedError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text(
                      " Something went wrong while loading your Notifications"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
