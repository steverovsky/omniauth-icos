require 'omniauth-oauth2'
require 'multi_json'
require 'securerandom'

module OmniAuth
  module Strategies
    class ICOS < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPES = 'hydra.consent offline'

      option :name, 'icos'

      option :client_options, {
        authorize_url: '/oauth2/auth',
        token_url:     '/oauth2/token',
        site:          'https://icosid.com'
      }

      option :authorize_params, {
        state:  SecureRandom.hex,
        scopes: DEFAULT_SCOPES
      }

      option :token_params, {
        state:  SecureRandom.hex,
        scopes: DEFAULT_SCOPES
      }

      uid { user_info['Id'] }

      info do 
        {
          :email                 => user_info['Email'],
          :phone                 => user_info['Phone'],
          :name                  => compact_full_name,
          :first_name            => user_info['FirstName'],
          :middle_name           => user_info['MiddleName'],
          :last_name             => user_info['LastName'],
          :county                => user_info['County'],
          :citizenship           => user_info['Citizenship'],
          :address               => user_info['Address'],
          :document_number       => user_info['DocumentNumber'],
          :use_g2fa              => user_info['UseG2fa'],
          :globalid_verify       => user_info['GlobalidVerify'],
          :globalid_agent_verify => user_info['GlobalidAgentVerify'],
          :netki_status          => user_info['NetkiStatus'],
          :eth_wallet            => user_info['EthWallet']
        }
      end
      
      extra do
        {
          :raw_info => raw_info
        }
      end

      def build_access_token
        options.token_params.merge!(:headers => {'Authorization' => basic_auth_header })
        super
      end

      def basic_auth_header
        'Basic ' + Base64.strict_encode64("#{options[:client_id]}:#{options[:client_secret]}")
      end

      def compact_full_name
        [user_info['FirstName'], user_info['MiddleName'], user_info['LastName']].reject { |name| name.empty? }.join(' ')
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/v1/services/client/').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      def user_info
        @user_info ||= raw_info.nil? ? {} : raw_info['Result']
      end
    end
  end
end

OmniAuth.config.add_camelization 'icos', 'ICOS'