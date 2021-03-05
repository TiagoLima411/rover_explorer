FactoryBot.define do
  factory :movement do
    x { 0 } 
    y { 0 }
    orientation { "N" }
    
    trait :first_movement do
      x {1}
      y {2}
      orientation {"N"}
    end
    
    trait :last_movement do
      x {1}
      y {3}
      orientation {"N"}
    end

    trait :out_of_bounds do
      x { 50 }
      y { 15 }
      orientation {"N"}
    end

    association :rover

  end
end
