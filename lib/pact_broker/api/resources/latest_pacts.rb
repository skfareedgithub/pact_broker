require 'pact_broker/api/resources/base_resource'

module PactBroker
  module Api
    module Resources
      class LatestPacts < BaseResource

        def content_types_provided
          [["application/hal+json", :to_json]]
        end

        def allowed_methods
          ["GET", "OPTIONS"]
        end

        def to_json
          PactBroker::Api::Decorators::PactCollectionDecorator.new(pacts).to_json(decorator_options)
        end

        def pacts
          @pacts ||= pact_service.find_latest_pacts
        end

        def policy_name
          :'pacts:pacts'
        end

        def policy_record
          pacts
        end
      end
    end
  end
end
