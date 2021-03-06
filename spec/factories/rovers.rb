FactoryBot.define do
  factory :rover do
    position { "12N" }
    comand { "LMLMLMLMM" }

    trait :second_rover do
      position { "33E" }
      comand { "MMRMMRMRRM" }
    end

    association :plateau
  end
end
