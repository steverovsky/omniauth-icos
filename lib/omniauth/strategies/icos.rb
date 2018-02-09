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
          :lang                  => user_info['Lang'],
          :county_code           => user_info['Country'],
          :city                  => user_info['City'],
          :citizenship           => user_info['Citizenship'],
          :address               => user_info['Address'],
          :state                 => user_info['State'],
          :dob                   => user_info['Dob'],
          :document_number       => user_info['DocumentNumber'],
          :document_type         => user_info['DocumentType'],
          :use_g2fa              => user_info['UseG2fa'],
          :gender                => user_info['Gender'],
          :kyc_status            => user_info['KycStatus'],
          :kyc_reason            => user_info['KycReason'],
          :kyc_at                => user_info['KycAt'],
          :is_verified           => user_info['IsVerified']
        }
      end

      extra do
        {
          :raw_info => raw_info
        }
      end

      def callback_url
        puts 'yes'
        full_host + script_name + callback_path
      end

      def redirect_url
        puts 'yes-22'
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      def compact_full_name
        [user_info['FirstName'], user_info['MiddleName'], user_info['LastName']].reject { |name| name.empty? }.join(' ')
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/v1/services/client/').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      def build_access_token
        puts 'BUILD'
        options.token_params.merge!(:headers => {'Authorization' => basic_auth_header })
        super
      end

      def basic_auth_header
        'Basic ' + Base64.strict_encode64("#{options[:client_id]}:#{options[:client_secret]}")
      end

      def user_info
        @user_info ||= raw_info.nil? ? {} : raw_info['Result']
      end
    end
  end
end

OmniAuth.config.add_camelization 'icos', 'ICOS'