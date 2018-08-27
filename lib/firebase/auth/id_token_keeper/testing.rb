# frozen_string_literal: true

module Firebase
  module Auth
    module IDTokenKeeper
      module Testing

        def self.generate_test_id_token(decoded_jwt)
          JWT.encode(decoded_jwt, nil, 'none')
        end

        def self.decode_test_id_token(encoded_jwt)
          JWT.decode(encoded_jwt, nil, false)
        end

        module Helpers
          extend ActiveSupport::Concern

          ::Firebase::Auth::IDTokenKeeper::IDToken.class_eval do
            def verified_id_token
              ::Firebase::Auth::IDTokenKeeper::Testing.decode_test_id_token(encoded_jwt)
            end
          end
        end
      end
    end
  end
end

