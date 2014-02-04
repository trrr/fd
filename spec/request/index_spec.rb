require 'spec_helper'

describe "Home page"  do
  describe "GET /" do
    it "render seccess" do 
      visit '/'
      expect(page.status_code).to be(200)
    end
  end
end