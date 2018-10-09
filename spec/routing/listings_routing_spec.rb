require 'rails_helper'

describe 'routing to listings' do
  it 'routes /listings to listings#index' do
    expect(get: '/listings').to route_to(
      controller: 'listings',
      action: 'index'
    )
  end

  it 'routes /listings/1 to listings#show' do
    expect(get: '/listings/1').to route_to(
      controller: 'listings',
      action: 'show',
      id: '1'
    )
  end

  it 'routes /listings/new to listings#new' do
    expect(get: '/listings/new').to route_to(
      controller: 'listings',
      action: 'new'
    )
  end

  it 'routes /listings/1/edit to listings#edit' do
    expect(get: '/listings/1/edit').to route_to(
      controller: 'listings',
      action: 'edit',
      id: '1'
    )
  end

  it 'routes /listings to listings#create' do
    expect(post: '/listings').to route_to(
      controller: 'listings',
      action: 'create'
    )
  end

  it 'routes /listings/1 to listings#update' do
    expect(patch: '/listings/1').to route_to(
      controller: 'listings',
      action: 'update',
      id: '1'
    )
  end

  it 'routes /listings/1 to listings#destroy' do
    expect(delete: '/listings/1').to route_to(
      controller: 'listings',
      action: 'destroy',
      id: '1'
    )
  end

  it 'routes /listings/1/publish to listings#publish' do
    expect(get: '/listings/1/publish').to route_to(
      controller: 'listings',
      action: 'publish',
      listing_id: '1'
    )
  end

  it 'routes /listings/1/unpublish to listings#unpublish' do
    expect(get: '/listings/1/unpublish').to route_to(
      controller: 'listings',
      action: 'unpublish',
      listing_id: '1'
    )
  end

  it 'routes /listings/search to listings#search' do
    expect(get: '/listings/search').to route_to(
      controller: 'listings',
      action: 'search'
    )
  end
end
