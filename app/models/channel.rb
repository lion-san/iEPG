class Channel
  include Mongoid::Document
  field :date, type: String
  field :region, type: String
  field :region_cd, type: String
  #field :iepg, type: Array
  embeds_many :iepgs
end
