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
      end
    end
  end
end

