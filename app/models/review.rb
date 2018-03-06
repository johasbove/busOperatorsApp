class Review < ApplicationRecord
  include Sortable
  add_sortable_scopes
  
  belongs_to :bus_operator

  after_create :update_average_rating

  scope :bus_operator, -> (id) { where(bus_operator_id: id) }

  private

  def update_average_rating
    average = self.class.bus_operator(bus_operator_id).average(:rating)
    bus_operator.update(average_rating: average)
  end
end
