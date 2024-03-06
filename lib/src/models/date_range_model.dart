
import 'dart:convert';

List<RangeDatePicker> rangeDatePickerFromJson(String str) =>
    List<RangeDatePicker>.from(json.decode(str).map((x) => RangeDatePicker.fromJson(x)));

String rangeDatePickerToJson(List<RangeDatePicker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RangeDatePicker {
  DateTime? showDates;
  bool? isSelected;

  RangeDatePicker({
    this.showDates,
    this.isSelected,
  });

  factory RangeDatePicker.fromJson(Map<String, dynamic> json) =>
      RangeDatePicker(
        showDates: json["show_dates"] == null ? null : DateTime.parse(json["show_dates"]),
        isSelected: json["is_selected"],
      );

  Map<String, dynamic> toJson() =>
      {
        "show_dates": showDates?.toIso8601String(),
        "is_selected": isSelected,
      };
}