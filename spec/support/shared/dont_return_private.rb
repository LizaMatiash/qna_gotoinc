shared_examples_for 'API dont return private' do
  it 'does not return private fields' do
    %w[password encrypted_password].each do |attr|
      expect(response.body).to_not have_json_path(attr)
    end
  end
end
