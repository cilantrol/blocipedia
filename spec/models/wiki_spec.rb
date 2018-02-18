require 'rails_helper'
include RandomData

RSpec.describe Wiki, type: :model do
  let(:wiki)    { create ( :wiki) }
  # { create( title: RandomData.random_sentence,
  #                       body: RandomData.random_sentence,
  #                       private: false,
  #                       user: 'asdf') }

  # it { is_expected.to have_many(:something) }
  # it { is_expected.to have_many(:something) }
  # it { is_expected.to have_many(:something) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  # it { should validate_presence_of(:user) }

  it { is_expected.to validate_length_of(:title).is_at_least(3) }
  it { is_expected.to validate_length_of(:body).is_at_least(15) }

  describe "attributes" do
    it "has title, body, private, user attributes" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, private: wiki.private)
      # ,user: wiki.user)
    end

    it "is public by default" do
      expect(wiki.private).to be(false)
    end
  end

end
