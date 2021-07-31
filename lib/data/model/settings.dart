class Settings {
  bool notice;
  String theme;
  int nextBudget;

  Settings(this.notice, this.theme, this.nextBudget);

  Settings.fromJson(Map<String, dynamic> jsonData)
      : notice = jsonData['notice'],
        theme = jsonData['theme'],
        nextBudget = jsonData['nextBudget'];

  Map<String, dynamic> toJson() => {
        'notice': notice,
        'theme': theme,
        'nextBudget': nextBudget,
      };
}
