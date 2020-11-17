# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OmniAuth::Trusona::IdToken do
  let(:jwt) { double(to_s: 'token') }

  subject { OmniAuth::Trusona::IdToken.new(jwt) }

  context 'masquerading as an OAuth2::AccessToken' do
    it 'can produce a token' do
      expect(subject.token).to eq('token')
    end

    it 'does not expire' do
      expect(subject.expires?).to eq(false)
    end

    it 'is not expired' do
      expect(subject.expired?).to eq(false)
    end

    it 'does nothing when refreshed' do
      expect(subject.refresh!).to eq(nil)
    end
  end

  describe '#nonce' do
    let(:jwt) do
      {
        nonce: 'something-random'
      }
    end

    it 'returns the nonce claim' do
      expect(subject.nonce).to eq('something-random')
    end
  end

  context 'OmniAuth AuthHash components' do
    let(:jwt) do
      {
        sub: 'user123',
        nonce: 'something-random',
        email: 'user@example.com'
      }
    end

    it 'uses the subject for uid' do
      expect(subject.uid).to eq('user123')
    end

    it 'includes email in info' do
      info = subject.info

      expect(info['email']).to eq('user@example.com')
    end

    describe '#extra' do
      let(:claims_hash) { { 'sub': 'user' } }
      let(:jwt) { double(to_hash: claims_hash) }

      it 'includes all claims as raw_info' do
        extra = subject.extra

        expect(extra['raw_info']).to eq(claims_hash)
      end
    end

    context 'when claims for the profile scope are included' do
      let(:jwt) do
        {
          sub: 'user123',
          nonce: 'something-random',
          email: 'user@example.com',
          given_name: 'John',
          family_name: 'Doe',
          nickname: 'John Doe'
        }
      end

      it 'includes the given name as first name' do
        info = subject.info

        expect(info['first_name']).to eq('John')
      end

      it 'includes the family name as the last name' do
        info = subject.info

        expect(info['last_name']).to eq('Doe')
      end

      it 'includes the nickname' do
        info = subject.info

        expect(info['nickname']).to eq('John Doe')
      end
    end
  end
end
