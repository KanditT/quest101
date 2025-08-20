# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do # rubocop:disable RSpec/MultipleDescribes
  it 'inherits from ActiveJob::Base' do
    expect(described_class < ActiveJob::Base).to be true
  end
end

RSpec.describe ApplicationMailer, type: :mailer do
  it 'inherits from ActionMailer::Base' do
    expect(described_class < ActionMailer::Base).to be true
  end

  it 'sets a default from email' do
    expect(described_class.default[:from]).to eq('from@example.com')
  end
end
