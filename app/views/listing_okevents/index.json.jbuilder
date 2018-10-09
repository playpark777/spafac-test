json.array!(@okevents) do |event|
  json.merge! start: event.start, end: event.end + 1.second
  json.extract! event, :id
  json.merge! title: I18n.t("alerts.listing_okevents.reason.#{event.reason}")
  json.merge! color: Settings.listing_okevents.color[event.reason]
  json.merge! allDay: true
end
