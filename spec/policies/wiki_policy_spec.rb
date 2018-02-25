require 'rails_helper'

RSpec.describe WikiPolicy do

  let(:my_user) { create(:user)}
  let(:my_wiki) { create(:wiki , user: my_user) }

  subject { described_class }

    context "not signed in" do
      let(:my_user) {nil}

      permissions :new?, :edit?, :create?, :update?, :destroy? do
        it "does not grant access other than viewing index and show " do
          expect(subject).not_to permit(my_user, my_wiki)
        end
      end
    end

    context "member signed in// crud on other member's wiki" do

      permissions :index?, :show?, :new?, :create? do
        it "grant access to view other's wiki " do
          expect(subject).to permit(my_user, my_wiki)
        end
      end

      permissions :edit?, :update?, :destroy? do
        it "no access to edit, delete,update for wiki you do not own " do
          expect(subject).not_to permit(my_user, my_wiki)
        end
      end
    end

    context "member signed in// own wiki crud" do

      permissions :edit?, :update?, :destroy? do
        it "grant access to view other's wiki " do
          expect(subject).to permit(my_user, Wiki.create!(user_id: user.id))
        end
      end
    end
end
