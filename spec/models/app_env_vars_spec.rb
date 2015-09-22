require 'rails_helper'
# FIXME: smelly
require_relative '../../app/models/app_env_vars'

RSpec.describe AppEnvVars do
  describe '.encode(env_vars_from_view)' do
    it 'transforms the given string into a hash' do
      env_vars_from_view = "FOO: BAR\nBAZ: BLA"
      hash = described_class.encode(env_vars_from_view)
      expect(hash).to eq({ 'FOO' => 'BAR', 'BAZ' => 'BLA' })
    end

    it 'upcases given all keys' do
      env_vars_from_view = "foo: BAR"
      hash = described_class.encode(env_vars_from_view)
      expect(hash).to eq({ 'FOO' => 'BAR' })
    end

    it 'handles leading and trailing whitespace' do
      env_vars_from_view = "    FOO:    BAR     "
      hash = described_class.encode(env_vars_from_view)
      expect(hash).to eq({ 'FOO' => 'BAR' })
    end
  end
end
