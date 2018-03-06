module Sortable
  extend ActiveSupport::Concern

  included do
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
  end

  # No se hace automaticamente
  # module ClassMethods
  #   def add_sortable_scopes
  #     scope :order_by_option, -> (attribute, opt) do
  #       case opt
  #       when :desc
  #         order("#{attribute} DESC")
  #       when :null_desc
  #         order("#{attribute} DESC NULLS LAST")
  #       else
  #         order(attribute)
  #       end
  #     end
  #   end
  # end
end
