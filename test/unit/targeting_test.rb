require 'test_plugin_helper'

describe Targeting do
  let(:targeting) { FactoryGirl.build(:targeting) }
  let(:bookmark) {bookmarks(:one)}

  context 'Able to be created with search term' do
    before { targeting.search_query = "name = foo" }
    it { assert targeting.save }
  end

  context 'able to be created with a bookmark' do
    before { targeting.bookmark = bookmark }
    it { assert targeting.save }
  end

  context 'cannot create without search term or bookmark' do
    it { refute targeting.save }
  end

  context 'cannot create with  search term and bookmark' do
    before do
      targeting.search_query = "name = foo"
      targeting.bookmark = bookmark
    end

    it { refute targeting.save }
  end

  context 'can resolve hosts via query' do
    before do
      host = FactoryGirl.create(:host)
      targeting.user = users(:admin)
      targeting.search_query = "name = #{host.name}"
      targeting.resolve_hosts
    end

    it { targeting.hosts.should_include(host) }
  end
end
