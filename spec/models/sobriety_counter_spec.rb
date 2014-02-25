require 'spec_helper'

describe SobrietyCounter do
  it 'should give back the proper color icon for one day sober' do
    expected = "silver"
    result = SobrietyCounter.token_for(DateTime.now - 1.minute)
    expect(result).to eq(expected)
  end

  it 'should give back the proper color icon for one month sober' do
    expected = "red"
    result = SobrietyCounter.token_for(DateTime.now - 1.month)
    expect(result).to eq(expected)
  end

  it 'should give back the proper color icon for two months sober' do
    expected = "gold"
    result = SobrietyCounter.token_for(DateTime.now - 2.months)
    expect(result).to eq(expected)
  end

  it 'should give back the proper color icon for three months sober' do
    expected = "emerald"
    result = SobrietyCounter.token_for(DateTime.now - 3.months)
    expect(result).to eq(expected)
  end

  it 'should give back the proper color icon for six months sober' do
    expected = "blue"
    result = SobrietyCounter.token_for(DateTime.now - 6.months)
    expect(result).to eq(expected)
  end

  it 'should give back the proper color icon for nine months sober' do
    expected = "purple"
    result = SobrietyCounter.token_for(DateTime.now - 9.months)
    expect(result).to eq(expected)
  end

  it 'should give back the proper color icon for more than one year sober' do
    expected = "bronze"
    result = SobrietyCounter.token_for(DateTime.now - 1.year)
    expect(result).to eq(expected)
  end


end