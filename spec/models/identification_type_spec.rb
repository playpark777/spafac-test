require 'rails_helper'

describe IdentificationType do
  before do
    @id_type = IdentificationType.create(name: "sample", available: true)
  end

  subject { @id_type }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :name }

  describe "availables scope" do
    it "returns availables identification types" do
      unavailable_type = IdentificationType.create(
        name: "unavailable", available: false
      )
      expect(IdentificationType.availables).not_to include(unavailable_type)
    end
  end
end
