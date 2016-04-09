require 'rails_helper'

RSpec.describe AppName do
  describe '.generate_unique' do
    it 'creates a name beginning with the probably upcoming sequential id' do
      expect(described_class.generate_unique).to match /.+-.+/
    end
  end
end
