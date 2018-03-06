class BusOperator < ApplicationRecord
  BUS_OPERATORS_UPDATE_URL = 'https://www.recorrido.cl/api/v2/es/bus_operators.json'
  MODEL_ATTRS = ['external_id', 'internal_name', 'official_name', 'bookable', 'phone', 'allows_e_ticketing', 'average_rating', 'payload']
  ORDER_ATTR = ['official_name', 'average_rating']
  has_many :reviews

  after_create :create_initial_reviews

  scope :order_by_option, -> (attribute, opt) do
    case opt
    when :desc
      order("#{attribute} DESC")
    when :null_desc
      order("#{attribute} DESC NULLS LAST")
    else
      order(attribute)
    end

  end

  def self.update
    response = RestClient.get(BUS_OPERATORS_UPDATE_URL)
    bus_operators = JSON.parse(response.body)['bus_operators']
    operator_ids = bus_operators.each do |operator|
      operator = format_operator operator
      bus_operator = find_or_create operator
    end
  end

  def rating_percentage
    average_rating.nil? ? 0 : average_rating * 100 / 5
  end

  private

  def create_initial_reviews
    return if average_rating.nil?
    10.times do
      review = self.reviews.build(rating: average_rating)
      review.save
    end
  end

  def self.find_or_create operator
    self.create_with(operator)
        .find_or_create_by(external_id: operator['external_id'])
  end

  def self.format_operator operator
    operator['payload'] = operator
    operator['external_id'] = operator.delete('id')
    operator.extract!(*MODEL_ATTRS)
  end
end
