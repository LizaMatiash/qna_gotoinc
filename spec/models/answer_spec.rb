require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject { build(:answer) }
  it { should belong_to(:question) }

  it_behaves_like 'Contains routes'

  it_behaves_like 'Rating Calulation'

  describe '#report_to_subscribers', :focus do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    subject { build(:answer, user: user, question: question) }

    it 'send email to question subscribers' do
      subject.question.subscribers.each { |user| expect(ReportMailer).to receive(:report).with(user, subject).and_call_original }
      subject.save!
    end
  end
end
