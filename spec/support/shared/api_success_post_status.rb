shared_examples_for 'API Success Post' do
  it 'return 200 status' do
    do_request(method, api_path, params: { access_token: '1234' })
    expect(response).to be_successful
  end
end
