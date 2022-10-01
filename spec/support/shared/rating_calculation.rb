shared_examples_for 'Rating Calulation' do
  it 'should calculate rating after create' do
    expect(subject).to receive(:rating)
    subject.save!
  end

  it 'should not calculate rating after update' do
    subject.save!
    expect(subject).to_not receive(:rating)
    subject.update(body: 'MyText')
  end
end
