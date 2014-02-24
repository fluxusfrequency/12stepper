require 'spec_helper'

describe SobrietyCounter do
  it 'should give back the proper color icon for one day sober' do
    expected = "silver_token_sm.png"
    result = SobrietyCounter.token_for(Time.now)
    expect(result).to eq(expected)
  end

  xit 'should give back the proper color icon for one month sober' do
    expected = "red_token_sm.png"
    result = SobrietyCounter.token_for(DateTime.now - 1.month)
    expect(result).to eq(expected)
  end

  xit 'should give back the proper color icon for two months sober' do
    expected = "gold_token_sm.png"
    result = SobrietyCounter.token_for(DateTime.now - 2.months)
    expect(result).to eq(expected)
  end

  xit 'should give back the proper color icon for three months sober' do
    expected = "emerald_token_sm.png"
    result = SobrietyCounter.token_for(DateTime.now - 3.months)
    expect(result).to eq(expected)
  end

  xit 'should give back the proper color icon for six months sober' do
    expected = "blue_token_sm.png"
    result = SobrietyCounter.token_for(DateTime.now - 6.months)
    expect(result).to eq(expected)
  end

  xit 'should give back the proper color icon for nine months sober' do
    # expected = "purple_token_sm.png"
    result = SobrietyCounter.token_for(DateTime.now - 9.months)
    expect(result).to eq(expected)
  end

  xit 'should give back the proper color icon for more than one year sober' do
    # expected = "bronze_token_sm.png"
    result = SobrietyCounter.token_for(DateTime.now - 1.year)
    expect(result).to eq(expected)
  end


end