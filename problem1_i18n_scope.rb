require 'i18n'
require 'dry-validation'

class Contract < Dry::Validation::Contract
  config.messages_file = File.join('errors.yml')

  params do
    required(:kafka).schema do
      %i[
        ssl_ca_cert
      ].each do |encryption_attribute|
        optional(encryption_attribute).maybe(:str?)
      end
    end
  end

  rule(:kafka) do
    failure(:invalid)
  end

  rule(kafka: :ssl_ca_cert) do
    failure(:invalid)
  end
end

p Contract.new.call({})
p Contract.new.call({ kafka: {} })
