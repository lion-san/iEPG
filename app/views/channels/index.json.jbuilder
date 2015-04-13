json.array!(@channels) do |channel|
  json.extract! channel, :id, :date, :region, :region_cd, :iepg
  json.url channel_url(channel, format: :json)
end
