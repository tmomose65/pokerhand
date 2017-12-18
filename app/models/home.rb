class Home
  # Formで使用するプロパティを定義する
  attr_accessor :card

  # Validationを定義する
  include ActiveModel::Validations

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value) rescue nil
    end
  end

end
