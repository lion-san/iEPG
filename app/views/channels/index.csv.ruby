csv_str = CSV.generate do |csv|
  #csv << @channels.column_names
  csv << @channels.attribute_names
    @channels.all.each do |channel|
    csv << channel.attributes.values_at(*@channels.attribute_names)
  end
end

NKF::nkf('--sjis -Lw', csv_str)

