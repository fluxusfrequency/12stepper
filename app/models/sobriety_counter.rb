class SobrietyCounter

  def self.token_for(date)
    milestones.each do |condition, color|
      return color if condition.call(date)
    end
  end

  def self.milestones
    {
      lambda {|date| date < DateTime.now - 1.year} => "bronze",
      lambda {|date| date < DateTime.now - 9.months} => "purple",
      lambda {|date| date < DateTime.now - 6.months} => "blue",
      lambda {|date| date < DateTime.now - 3.months} => "emerald",
      lambda {|date| date < DateTime.now - 2.months} => "gold",
      lambda {|date| date < DateTime.now - 1.month} => "red",
      lambda {|date| true} => "silver"
    }
  end

 
end