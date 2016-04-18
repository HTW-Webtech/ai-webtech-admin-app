require 'rails_helper'

describe App do
  subject { described_class.new(id: 1, name: 'funny-capybara') }

  describe '#public_url' do
    before do
      allow(subject).to receive(:cc).with(:site).and_return(double('Site', app_hostname: 'foo.bar'))
    end

    it 'returns the correct url' do
      expect(subject.public_url).to eq 'http://1-funny-capybara.foo.bar'
    end
  end
end
