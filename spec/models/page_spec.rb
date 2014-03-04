require 'spec_helper'

describe Page do
  it "has a valid factory" do
    build(:page).should be_valid
  end

  it "is invalid without a title" do
    build(:page, title: nil).should_not be_valid
  end

  it "has a unique slug" do
    create(:page, slug: 'test')
    build(:page, slug: 'test').should_not be_valid
  end

  describe '#primary' do
    it 'returns page without parents' do
      page = create(:page, slug: 'primary')
      Page.primary('primary').should eq(page)
    end

    it 'doesn\'t return page with parent' do
      page = create(:page, slug: 'secondary', parent: create(:page))
      Page.primary('secondary').should be_nil
    end
  end

  describe '#secondary' do
  end
end
