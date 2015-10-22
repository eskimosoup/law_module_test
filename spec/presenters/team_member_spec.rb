require "rails_helper"
#  rspec --tag "team_member"
RSpec.describe TeamMemberPresenter, type: :presenter, team_member: true do
  let(:team_member) { build(:team_member) }
  subject(:team_member_presenter) { TeamMemberPresenter.new(object: team_member, view_template: view)}

  describe "delegations", :delegation do
    it { should delegate_method(:forename).to(:team_member) }
    it { should delegate_method(:surname).to(:team_member) }
    it { should delegate_method(:role).to(:team_member) }
  end

  describe "standard team_member" do
    it "returns the name" do
      expect(team_member_presenter.full_name).to eq([team_member.forename, team_member.surname].join(' '))
    end

    it "returns the Google Plus link" do
      expect(team_member_presenter.linked_google_plus('Google+', { title: 'Google+', target: '_blank' })).to eq(link_to 'Google+', team_member.google_plus, title: 'Google+', target: '_blank')
    end

    it "returns the Twitter link" do
      expect(team_member_presenter.linked_twitter('Follow me on Twitter', { title: 'Follow me on Twitter', target: '_blank' })).to eq(link_to 'Follow me on Twitter', team_member.twitter_link, title: 'Follow me on Twitter',  target: '_blank')
    end

    it "returns the Facebook link" do
      expect(team_member_presenter.linked_twitter('Add me on Facebook', { title: 'Add me on Facebook', target: '_blank' })).to eq(link_to 'Add me on Facebook', team_member.facebook_link, title: 'Add me on Facebook',  target: '_blank')
    end

    it "returns the html formatted profile" do
      expect(team_member_presenter.profile).to eq(raw team_member.profile)
    end

    it "returns the dx number" do
      expect(team_member_presenter.dx_number).to eq(team_member.dx_number)
    end

    it "returns the mobile" do
      expect(team_member_presenter.mobile_number).to eq(team_member.mobile_number)
    end
  end

  describe "images" do
    describe "no image" do
      it "show_image should return nil" do
        expect(team_member_presenter.show_image).to eq(nil)
      end
      it "index_image should return nil" do
        expect(team_member_presenter.index_image).to eq(nil)
      end
    end

    describe "has image" do
      let(:team_member) { build(:team_member_with_image) }
      subject(:team_member_presenter) { TeamMemberPresenter.new(object: team_member, view_template: view)}

      it "show_image should not return nil" do
        expect(team_member_presenter.show_image(alt: team_member_presenter.full_name)).to eq(image_tag(team_member.image.show, alt: [team_member.forename, team_member.surname].join(' ')))
      end

      it "index image should not return nil" do
        expect(team_member_presenter.index_image(alt: team_member_presenter.full_name)).to eq(image_tag(team_member.image.index, alt: [team_member.forename, team_member.surname].join(' ')))
      end
    end
  end
end
