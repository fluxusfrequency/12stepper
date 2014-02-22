class SobrietyCounter
  include UsersHelper

  def self.token_for(date)
    distance = new.days_ago(date)
    result = lookups.keys.select {|range| range.include?(distance)}
    result.empty? ? "light_green_token_sm.png" : lookups[result.first]
  end

  def self.lookups
    { (1..1) => "blue_token_sm.png",
      (10..30) => "green_token_sm.png",
      (30..90) => "red_token_sm.png",
      (90..365) => "orange_token_sm.png" }
  end
end