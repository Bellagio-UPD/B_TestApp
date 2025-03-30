import 'package:equatable/equatable.dart';

class NotificationsEntity extends Equatable {
  final String? MessageId;
  final String? Content;
  final String? Sender;
  final String? Receiver;
  final String? RecieverContact;
  final String? TimeStamp;
  final String? NotificationType;
  final String? Subject;
  final String? ServiceProvider;
  final bool? Deleted;

  const NotificationsEntity({
     this.MessageId,
     this.Content,
     this.Sender,
     this.Receiver,
     this.RecieverContact,
     this.TimeStamp,
     this.NotificationType,
     this.Subject,
     this.ServiceProvider,
     this.Deleted,
  });

  @override
  List<Object?> get props => [
        MessageId,
        Content,
        Sender,
        Receiver,
        RecieverContact,
        TimeStamp,
        NotificationType,
        Subject,
        ServiceProvider,
        Deleted,
      ];
}
