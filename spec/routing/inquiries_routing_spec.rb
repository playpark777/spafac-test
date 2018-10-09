require 'rails_helper'

describe "routing to inquiries" do
  it 'routes /inquiries/new to inquiries#new' do
    expect(get: '/inquiries/new').to route_to(
      controller: 'inquiries',
      action: 'new',
    )
  end

  it 'routes /inquiries/confirm to inquiries#confirm' do
    expect(post: '/inquiries/confirm').to route_to(
      controller: 'inquiries',
      action: 'confirm',
    )
  end

  it 'routes /inquiries to inquiries#create' do
    expect(post: '/inquiries').to route_to(
      controller: 'inquiries',
      action: 'create',
    )
  end
end
