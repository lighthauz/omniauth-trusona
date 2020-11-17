# frozen_string_literal: true

require 'spec_helper'

describe OmniAuth::Strategies::Trusona do
  subject do
    OmniAuth::Strategies::Trusona.new({})
  end

  it 'has the correct scope' do
    expect(subject.options.scope).to eq('openid email profile')
  end

  it 'has the correct authorize_options' do
    expect(subject.options.authorize_options).to eq(%i[scope state])
  end

  context 'client options' do
    it 'uses the Trusona Gateway for the site' do
      expect(subject.options.client_options.site).to eq('https://gateway.trusona.net')
    end

    it 'has the correct authorize_url' do
      expect(subject.options.client_options.authorize_url).to eq('/oidc')
    end

    it 'has the correct jwks_url' do
      expect(subject.options.client_options.jwks_url).to eq('/oidc/certs')
    end
  end

  describe '#jwks_url' do
    it 'should return the correct jwks url' do
      expect(subject.jwks_url).to eq(URI('https://gateway.trusona.net/oidc/certs'))
    end
  end

  context 'OmniAuth AuthHash DSL' do
    let(:access_token) do
      double(uid: 'uid', info: {}, extra: { 'raw_info' => {} })
    end

    before(:each) do
      allow(subject).to receive(:access_token).and_return(access_token)
    end

    it 'should get the uid from the access token' do
      expect(subject.uid).to eq('uid')
    end

    it 'should get the info hash from the token' do
      expect(subject.info).to eq({})
    end

    it 'should get the extra hash from the token' do
      expect(subject.extra).to eq({ 'raw_info' => {} })
    end
  end
end
