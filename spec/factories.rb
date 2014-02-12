FactoryGirl.define do

  factory :category do
    name  "Tech"
    description "All about Tech"
  end

  factory :author do
    profile "nokia"
    category
  end

  factory :post do
    post_id "113984671987671_10151994226948621"
    sequence(:message) {|n| "An example of the text number #{n}" }
    updated_time "2014-01-20 19:48:01"
    picture "https://fbexternal-a.akamaihd.net/safe_image.php"
    category_id "2"
    author
  end

end
