import 'package:flutter/material.dart';
import '../models/video.dart';
import '../services/api_service.dart';
import '../utils/url_helper.dart';

class VideoListPage extends StatelessWidget {
  const VideoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: ApiService.fetchVideos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Erro: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Nenhum vídeo encontrado"));
        }

        final videos = snapshot.data!;
        return ListView.builder(
          itemCount: videos.length,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
          itemBuilder: (context, index) {
            final video = videos[index];
            return InkWell(
              onTap: () => abrirLink(video.link),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ), // raio da borda
                      child: Image.network(
                        video.cover,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        video.titulo,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
