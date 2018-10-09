require 'rails_helper'

describe "routing to identifications" do
  it "routes /profile/identification/ to identifications#show" do
    expect(get: "/profile/identification").to route_to(
      controller: "identifications",
      action: "show",
    )
  end

  it "routes /profile/identification/new to identifications#new" do
    expect(get: "/profile/identification/new").to route_to(
      controller: "identifications",
      action: "new",
    )
  end

  it "routes /profile/identification to identifications#create" do
    expect(post: "/profile/identification").to route_to(
      controller: "identifications",
      action: "create",
    )
  end

  it "routes /profile/identification to identifications#destroy" do
    expect(delete: "/profile/identification").to route_to(
      controller: "identifications",
      action: "destroy",
    )
  end
end
