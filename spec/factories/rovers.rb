FactoryBot.define do
  factory :rover do
    position { "12N" }
    comand { "LMLMLMLMM" }

    association :plateau
  end
end
