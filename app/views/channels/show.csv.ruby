csv_str = CSV.generate do |csv|
  #csv << @channels.column_names
  csv << @channel.iepgs.attribute_names
    @channel.iepgs.each do |iepg|
    csv << iepg.attributes.values_at(*@channel.iepgs.attribute_names)
  end
end

NKF::nkf('--sjis -Lw', csv_str)

