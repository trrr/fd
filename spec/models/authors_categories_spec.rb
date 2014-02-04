require 'spec_helper'

describe AuthorsCategories do
  it {should belong_to(:author)}
  it {should belong_to(:category)}
end
