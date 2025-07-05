import 'package:flutter/material.dart';
import 'package:tekmob_hitnews/core/themes/app_colors.dart';
import 'package:tekmob_hitnews/core/themes/app_text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  final List<Map<String, String>> dummyNotifications = const [
    {
      'title': 'Berita Terbaru: AI Mengubah Dunia',
      'body':
          'Artikel baru tentang dampak AI pada industri teknologi telah diterbitkan.',
      'time': '2025-07-04T10:30:00Z',
      'type': 'news',
    },
    {
      'title': 'Pembaruan Aplikasi Tersedia!',
      'body':
          'Versi terbaru TekMob HitNews kini tersedia dengan peningkatan performa.',
      'time': '2025-07-03T18:00:00Z',
      'type': 'system',
    },
    {
      'title': 'Artikel Populer Minggu Ini',
      'body':
          'Lihat artikel yang paling banyak dibaca minggu ini: "Masa Depan Kendaraan Listrik".',
      'time': '2025-07-02T09:15:00Z',
      'type': 'news',
    },
    {
      'title': 'Akun Anda Berhasil Diperbarui',
      'body': 'Informasi profil Anda telah berhasil disimpan.',
      'time': '2025-07-01T14:45:00Z',
      'type': 'account',
    },
    {
      'title': 'Jangan Lewatkan: Diskon Langganan Premium!',
      'body':
          'Dapatkan akses tak terbatas ke semua fitur dengan diskon 50% untuk langganan tahunan.',
      'time': '2025-06-30T11:00:00Z',
      'type': 'promo',
    },
  ];

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'news':
        return Icons.article;
      case 'system':
        return Icons.info_outline;
      case 'account':
        return Icons.person_outline;
      case 'promo':
        return Icons.discount;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('id', timeago.IdMessages());

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor, // Warna dinamis
      appBar: AppBar(title: const Text('Notifikasi'), centerTitle: true),
      body:
          dummyNotifications.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off,
                      size: 80,
                      color: Theme.of(context).iconTheme.color,
                    ), // Warna dinamis
                    const SizedBox(height: 16),
                    Text(
                      'Tidak ada notifikasi baru.',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ), // Warna dinamis
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: dummyNotifications.length,
                itemBuilder: (context, index) {
                  final notification = dummyNotifications[index];
                  final DateTime? notificationTime = DateTime.tryParse(
                    notification['time']!,
                  );

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Theme.of(context).cardColor, // Warna dinamis
                    child: InkWell(
                      onTap: () {
                        print('Notification tapped: ${notification['title']}');
                      },
                      borderRadius: BorderRadius.circular(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              _getNotificationIcon(notification['type']!),
                              color: AppColors.primaryColor,
                              size: 28,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notification['title']!,
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleMedium?.color,
                                    ), // Warna dinamis
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification['body']!,
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ), // Warna dinamis
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      notificationTime != null
                                          ? timeago.format(
                                            notificationTime,
                                            locale: 'id',
                                          )
                                          : 'Waktu tidak diketahui',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall?.color,
                                      ), // Warna dinamis
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
