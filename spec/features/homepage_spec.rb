describe 'the homepage', type: :feature, js: true do
  before { visit '/' }

  it 'has the page title' do
    expect(find('.site-title').text).to eq('Stevie Codes')
  end
end
