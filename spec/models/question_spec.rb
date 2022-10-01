require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { build(:question) }
  it { should validate_presence_of :title }
  it { should have_many(:answers) }

  it_behaves_like 'Contains routes'

  its(:title) { should == 'MyString1' }
  its(:body) { should == 'MyText1' }

  it_behaves_like 'Rating Calulation'
end
