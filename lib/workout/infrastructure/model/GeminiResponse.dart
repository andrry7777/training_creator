class GeminiResponseModel {
  final List<GeminiCandidateModel> candidates;

  GeminiResponseModel({required this.candidates});

  factory GeminiResponseModel.fromJson(Map<String, dynamic> json) {
    final candidatesJson = json['candidates'] as List<dynamic>? ?? [];
    final candidates = candidatesJson
        .map((candidateJson) => GeminiCandidateModel.fromJson(candidateJson))
        .toList();

    return GeminiResponseModel(candidates: candidates);
  }
}

class GeminiCandidateModel {
  final GeminiContentModel content;

  GeminiCandidateModel({required this.content});

  factory GeminiCandidateModel.fromJson(Map<String, dynamic> json) {
    return GeminiCandidateModel(
      content: GeminiContentModel.fromJson(json['content']),
    );
  }
}

class GeminiContentModel {
  final List<GeminiPartModel> parts;

  GeminiContentModel({required this.parts});

  factory GeminiContentModel.fromJson(Map<String, dynamic> json) {
    final partsJson = json['parts'] as List<dynamic>? ?? [];
    final parts = partsJson
        .map((partJson) => GeminiPartModel.fromJson(partJson))
        .toList();

    return GeminiContentModel(parts: parts);
  }
}

class GeminiPartModel {
  final String text;

  GeminiPartModel({required this.text});

  factory GeminiPartModel.fromJson(Map<String, dynamic> json) {
    return GeminiPartModel(
      text: json['text'] ?? '',
    );
  }
}