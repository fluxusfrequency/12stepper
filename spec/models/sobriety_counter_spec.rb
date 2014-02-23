require 'spec_helper'

describe SobrietyCounter do
  it 'should give back the proper color icon for one day sober' do
    expected = "blue_token_sm.png"
    result = SobrietyCounter.token_for(Time.now)
    expect(result).to eq(expected)
  end

  it 'should give back the proper color icon for ten days sober' do
    expected = "green_token_sm.png"
    result = SobrietyCounter.token_for(Date.today - 10)
    expect(result).to eq(expected)
  end

  it 'should give back the proper color icon for thirty days sober' do
    expected = "red_token_sm.png"
    result = SobrietyCounter.token_for(Date.today - 30)
    expect(result).to eq(expected)
  end

  it 'should give back the proper color icon for ninety days sober' do
    expected = "orange_token_sm.png"
    result = SobrietyCounter.token_for(Date.today - 90)
    expect(result).to eq(expected)
  end

  it 'should give back the proper color icon for more than a year sober' do
    expected = "light_green_token_sm.png"
    result = SobrietyCounter.token_for(Date.today - 366)
    expect(result).to eq(expected)
  end
end