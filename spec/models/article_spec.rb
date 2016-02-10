require 'rails_helper'
#  rspec --tag 'article'
RSpec.describe Article, type: :model, article: true do
  describe 'validations', :validation do
    subject(:article) { build(:article) }
    # or for validating carrierwave items: let(:article) { create(:article) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:date) }
    it { should validate_uniqueness_of(:suggested_url).allow_blank.case_insensitive.with_message('is already taken, leave blank to generate automatically') }
  end

  describe 'custom validation', :validation do
    subject(:article) { build(:article) }

    it 'ensures dates are in the future' do
      article.date = Date.yesterday
      expect(article.valid?).to be false
      expect(article.errors[:date]).to include("can't be in the past")
    end
  end

  describe 'scopes', :scope do
    let(:article) { create(:article) }
    let(:hidden_article) { create(:article, display: false) }
    let(:future_article) { create(:article, date: Date.tomorrow) }

    it 'only returns displayed' do
      expect(Article.displayed).not_to include hidden_article
    end

    it 'only returns past articles' do
      expect(Article.displayed).not_to include future_article
    end
  end

  describe 'friendly id', :friendly_id do
    let(:article) { create(:article) }

    it 'creates a slug if title changed' do
      article.title = 'My new title'
      expect(article.should_generate_new_friendly_id?).to be true
    end

    it 'creates a slug if suggested_url changed' do
      article.suggested_url = 'my-new-titled-article'
      expect(article.should_generate_new_friendly_id?).to be true
    end

    it 'does not create slug when other attributes changed' do
      article = create(:article)
      article.content = 'Gobbledegook'
      expect(article.should_generate_new_friendly_id?).to be false
    end
  end
end
