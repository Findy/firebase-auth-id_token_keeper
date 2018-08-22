# frozen_string_literal: true
require 'jwt'

module Firebase
  module Auth
    module IDTokenKeeper
      class IDToken
        attr_accessor :encoded_jwt

        FIREBASE_ALGORITHM = 'RS256'

        def initialize(encoded_jwt)
          self.encoded_jwt = encoded_jwt
        end

        def verified_id_token
          decoded_jwt if verify!
        end

        private

        def verify!
          verify_header && verify_payload && verify_signature
        end

        def verify_header
          # Algorithm must be match Firebase algorithm.
          raise 'Invalid alg in ID Token header.' if jwt_header['alg'] != FIREBASE_ALGORITHM

          # Key ID must be listed at public keys endpoint.
          raise 'Invalid kid in ID Token header.' unless public_keys_endpoint.exist_public_key_by?(kid: jwt_header['kid'])

          true
        end

        def verify_payload
          # Expiration time must be in the future.
          raise 'Invalid exp in payload.' if jwt_payload['exp'] < Time.now.to_i

          # Issued-at time must be in the past.
          raise 'Invalid iat in payload.' if Time.now.to_i < jwt_payload['iat']

          # Audience must be match Firebase project ID.
          raise 'Invalid aud in payload.' if jwt_payload['aud'] != IDTokenKeeper.config.firebase_project_id

          # Issuer must be match Firebase issuer URI.
          raise 'Invalid iss in payload.' if jwt_payload['iss'] != firebase_issuer_uri

          # Subject must be a non-empty string.
          raise 'Invalid sub in payload.' if jwt_payload['sub'].strip.empty?

          # Authentication time must be in the past.
          raise 'Invalid auth_time in payload.' if Time.now.to_i < jwt_payload['auth_time']

          true
        end

        def verify_signature
          JWT.decode(encoded_jwt, certification.public_key, true, { algorithm: FIREBASE_ALGORITHM, verify_iat: true })

          true
        rescue JWT::ExpiredSignature => e
          raise 'Signature has expired.'
        end

        def certification
          public_keys_endpoint.find_certificate_by(kid: jwt_header['kid'])
        end

        def public_keys_endpoint
          @public_keys_endpoint ||= PublicKeysEndpoint.new
        end

        def decoded_jwt
          @decoded_jwt ||= JWT.decode(encoded_jwt, nil, false, { algorithm: FIREBASE_ALGORITHM })
        rescue JWT::DecodeError => e
          raise 'Invalid JWT format.'
        end

        def jwt_header
          decoded_jwt[1]
        end

        def jwt_payload
          decoded_jwt[0]
        end

        private

        def firebase_issuer_uri
          "https://securetoken.google.com/#{IDTokenKeeper.config.firebase_project_id}"
        end
      end
    end
  end
end
