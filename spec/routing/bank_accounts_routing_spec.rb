require 'rails_helper'

describe "routing to bank_accounts" do
  it "routes /profile/bank_account/ to bank_accounts#show" do
    expect(get: "/profile/bank_account").to route_to(
      controller: "bank_accounts",
      action: "show",
    )
  end

  it "routes /profile/bank_account/new to identifications#new" do
    expect(get: "/profile/bank_account/new").to route_to(
      controller: "bank_accounts",
      action: "new",
    )
  end

  it "routes /profile/bank_account to identifications#create" do
    expect(post: "/profile/bank_account").to route_to(
      controller: "bank_accounts",
      action: "create",
    )
  end

  it "routes /profile/bank_account to identifications#destroy" do
    expect(delete: "/profile/bank_account").to route_to(
      controller: "bank_accounts",
      action: "destroy",
    )
  end
end
