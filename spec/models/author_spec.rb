require 'spec_helper'

describe Author do
  it {should have_many(:posts)}
  it {should belong_to(:category)}
end

