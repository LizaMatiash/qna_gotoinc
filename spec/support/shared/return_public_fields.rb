shared_examples_for 'API return Success' do
  it 'return all public fields' do
    list.each do |attr|
      expect(response.body).to be_json_eql(send(model.to_sym).send(attr.to_sym).to_json).at_path((list_path + attr).to_s)
    end
  end
end
