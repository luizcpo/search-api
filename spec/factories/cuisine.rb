
FactoryBot.define do
  CUISINE_NAMES =  %w(American Chinese Thai Italian French Japanese Turkish Korean Vietnamese Indian Spanish Greek Mexican Malaysian African German Indonesian Russian Other)
  factory :cuisine do
    name { CUISINE_NAMES[rand(0..18)] }
  end
end
