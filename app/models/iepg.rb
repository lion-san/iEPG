class Iepg
  include Mongoid::Document
  field :station, type: String
  field :station_name, type: String
  field :year, type: String
  field :month, type: String
  field :date, type: String
  field :start_time, type: String
  field :end_time, type: String
  field :title, type: String
  field :subtitle, type: String
  field :performer, type: String
  field :subperformer, type: String
  field :program_id, type: String
  field :genre, type: String
  field :subgenre, type: String
  field :detail, type: String

  #embedded_in :channel, :inverse_of => :iepg
  embedded_in :channel

end
