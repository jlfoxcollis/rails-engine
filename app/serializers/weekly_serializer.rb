class WeeklySerializer
  include FastJsonapi::ObjectSerializer
  attribute :week do |object|
    object.week.strftime("%Y-%m-%d")
  end
  attribute :revenue

end