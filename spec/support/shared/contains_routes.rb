shared_examples_for 'Contains routes' do
  it { should validate_presence_of :body }
  it { should have_many(:attachments) }
  it { should accept_nested_attributes_for :attachments }
  it { should have_many(:votes) }
end
