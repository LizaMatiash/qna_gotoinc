require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { build(:question) }
  it { should validate_presence_of :title }
  it { should have_many(:answers) }
  it { should have_many(:subscribe_lists).dependent(:destroy) }
  it { should have_many(:subscribers) }

  it_behaves_like 'Contains routes'

  its(:title) { should == 'MyString1' }
  its(:body) { should == 'MyText1' }

  it_behaves_like 'Rating Calulation'

  describe 'Subscriprions' do
    let(:user) { create(:user) }
    let(:user1) { create(:user) }
    let(:question) { create(:question, user: user) }

    describe '#subscribe_author' do
      subject { build(:question, user: user) }

      it 'adds user to subscribers after create' do
        expect(subject).to receive(:subscribe).with(subject.user)
        subject.save!
      end
    end

    describe '#subscribe' do
      it 'add given user to subscribers' do
        expect { question.subscribe(user1) }.to change(question.subscribers, :count).by 1
      end

      it 'doesnt add user to subscribers if he is already there' do
        expect { question.subscribe(question.user) }.to_not change(question.subscribers, :count)
      end
    end

    describe '#unsubscribe' do
      it 'delete given user from subscribers' do
        expect { question.unsubscribe(user) }.to change(question.subscribers, :count).by(-1)
      end

      it 'doesnt delete user from subscribers if he is not in' do
        expect { question.unsubscribe(user1) }.to_not change(question.subscribers, :count)
      end
    end
  end
end
