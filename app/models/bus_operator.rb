class BusOperator < ApplicationRecord
  BUS_OPERATORS_UPDATE_URL = 'https://www.recorrido.cl/api/v2/es/bus_operators.json'
  MODEL_ATTRS = ['external_id', 'internal_name', 'official_name', 'bookable', 'phone', 'allows_e_ticketing', 'average_rating', 'payload']
  has_many :reviews

  def self.update
    response = RestClient.get(BUS_OPERATORS_UPDATE_URL)
    bus_operators = JSON.parse(response.body)['bus_operators']
    operator_ids = bus_operators.each do |operator|
      operator = format_operator operator
      find_or_create operator
    end
  end

  private

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
