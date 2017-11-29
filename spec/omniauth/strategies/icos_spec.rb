require 'spec_helper'

describe OmniAuth::Strategies::Icos do
  subject do
    OmniAuth::Strategies::Icos.new({})
  end

  context 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq 'icos'
    end

    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq 'https://icosid.com'
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options[:authorize_url]).to eq '/oauth2/auth'
    end

    it 'should have correct token url' do
      expect(subject.options.client_options[:token_url]).to eq '/oauth2/token'
    end
  end

  context 'default scopes' do
    it 'should have correct default scope' do
      expect(OmniAuth::Strategies::Icos::DEFAULT_SCOPES).to eq 'hydra.consent offline'
    end
  end
end
