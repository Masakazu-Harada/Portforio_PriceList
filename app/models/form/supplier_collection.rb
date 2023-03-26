class Form::SupplierCollection < Form::Base
  FORM_COUNT = 4
  attr_accessor :suppliers

  def initialize(attributes = {})
    super attributes
    self.suppliers = FORM_COUNT.times.map { Supplier.new() } unless self.suppliers.present?
  end

  def suppliers_attributes=(attributes)
    self.suppliers = attributes.map { |_, v| Supplier.new(v) }
  end

  def save
    Supplier.transaction do
      self.suppliers.map(&:save!)
    end
      return true
  rescue => e
    return false
  end
end
