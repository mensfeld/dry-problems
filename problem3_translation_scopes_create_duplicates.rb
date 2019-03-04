require 'i18n'
require 'dry-validation'

class Contract < Dry::Validation::Contract
  config.messages_file = File.join('errors.yml')

  params do
    required(:kafka3).filled(:str?)
    required(:kafka4).filled(:str?)
  end

  rule(:kafka3) do
    failure(:not_with_2_a) unless with_2_a?(values[:kafka3])
  end

  rule(:kafka4) do
    failure(:not_with_2_a) unless with_2_a?(values[:kafka4])
  end

  def with_2_a?(value)
    value.count('a') == 2
  end
end

p Contract.new.call(kafka3: 'aaaaaa', kafka4: 'aaaaa')
