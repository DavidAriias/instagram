class PageInfo {
    final bool hasNextPage;
    final String? endCursor;

    PageInfo({
        required this.hasNextPage,
        required this.endCursor,
    });

    factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        hasNextPage: json["hasNextPage"],
        endCursor: json["endCursor"],
    );

    Map<String, dynamic> toJson() => {
        "hasNextPage": hasNextPage,
        "endCursor": endCursor,
    };
}