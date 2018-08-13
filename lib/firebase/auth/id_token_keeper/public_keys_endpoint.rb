# frozen_string_literal: true
require 'json'
require 'open-uri'

module Firebase
  module Auth
    module IDTokenKeeper
      class PublicKeysEndpoint
        PUBLIC_KEYS_URI = 'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'

        def find_public_key_by(kid:)
          public_keys[kid]
        end

        def find_certificate_by(kid:)
          OpenSSL::X509::Certificate.new(public_keys[kid]) if exist_public_key_by?(kid: kid)

        end

        def exist_public_key_by?(kid:)
          public_keys.has_key?(kid)
        end

        def public_keys
          @public_keys ||= if response_status == 200
                              JSON.parse(response_body)
                            else
                              []
                            end
        end

        def response_body
          @response_body ||= response.read
        end

        def response_status
          @response_status ||= response.status[0].to_i
        end

        def response
          @response ||= open(PUBLIC_KEYS_URI)
        end
      end
    end
  end
end
