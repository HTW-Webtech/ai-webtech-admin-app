require 'rails_helper'
# FIXME: smelly
require_relative '../../app/models/app_name'

RSpec.describe AppName do
  describe '.generate_unique' do
    it 'creates a name beginning with the probably upcoming sequential id' do
      expect(App).to receive(:count).and_return(1)
      expect(described_class.generate_unique).to match /2-.+/
    end
  end
end
