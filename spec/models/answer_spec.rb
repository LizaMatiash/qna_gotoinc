require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject { build(:answer) }
  it { should belong_to(:question) }

  it_behaves_like 'Contains routes'

  it_behaves_like 'Rating Calulation'
end
