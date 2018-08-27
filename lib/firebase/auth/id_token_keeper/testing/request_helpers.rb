# frozen_string_literal: true

require 'firebase/auth/id_token_keeper/testing'

module Firebase
  module Auth
    module IDTokenKeeper
      module Testing
        module RequestHelpers
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

