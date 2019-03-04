require 'i18n'
require 'dry-validation'

class Contract < Dry::Validation::Contract
  config.messages_file = File.join('errors.yml')

  params do
    required(:kafka).schema do
      %i[
        ssl_ca_cert
        ssl_ca_cert2
      ].each do |encryption_attribute|
        optional(encryption_attribute).maybe(:str?)
      end
    end
  end

  rule(kafka: :ssl_ca_cert2) do
    failure(:not_with_2_a) unless with_2_a?(values[:kafka][:ssl_ca_cert2])
  end

  rule(kafka: :ssl_ca_cert) do
    failure(:not_with_2_a) unless with_2_a?(values[:kafka][:ssl_ca_cert])
  end

  def with_2_a?(value)
    value.count('a') == 2
  end
end

p Contract.new.call({ kafka: { ssl_ca_cert: '', ssl_ca_cert2: 'aaa' } })
