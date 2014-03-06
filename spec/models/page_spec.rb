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
    it 'returns page without parent' do
      page = create(:page, slug: 'primary')
      Page.primary('primary').should eq(page)
    end

    it 'doesn\'t return page with parent' do
      create(:page, slug: 'secondary', parent: create(:page))
      Page.primary('secondary').should be_nil
    end
  end

  describe '#secondary' do
    it 'returns page with a parent' do
      parent = create(:page, slug: 'primary')
      child  = create(:page, slug: 'secondary', parent: parent)
      Page.secondary('primary', 'secondary').should eq(child)
    end

    it 'doesn\'t return page without parent' do
      create(:page, slug: 'primary')
      create(:page, slug: 'secondary')
      Page.secondary('primary', 'secondary').should be_nil
    end
  end
end
