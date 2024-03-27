class QuotesModel {
  dynamic quoteText;
  String? quoteAuthor;
  String? senderName;
  String? senderLink;
  String? quoteLink;

  QuotesModel({
    this.quoteText,
    this.quoteAuthor,
    this.senderName,
    this.senderLink,
    this.quoteLink,
  });

  factory QuotesModel.fromJson(Map<String, dynamic> json) => QuotesModel(
    quoteText: json["quoteText"],
    quoteAuthor: json["quoteAuthor"],
    senderName: json["senderName"],
    senderLink: json["senderLink"],
    quoteLink: json["quoteLink"],
  );

  Map<String, dynamic> toJson() => {
    "quoteText": quoteText,
    "quoteAuthor": quoteAuthor,
    "senderName": senderName,
    "senderLink": senderLink,
    "quoteLink": quoteLink,
  };
}
