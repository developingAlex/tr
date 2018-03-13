require 'spec_helper'

describe Robot do
  before :each do
    @testtable = Table.new(5,5)
    @testbot = Robot.new(@testtable)
  end

  it "reports that it's ready to be placed on the table if it has not yet been placed" do
    expect(@testbot.report).to eql("I'm ready to be placed on the table")
  end

  it "will fail to be placed on a table if the coords are 'off' the table" do
    expect(@testbot.place(6,88,'N')).to eql(false)
  end

  it "will be placed on a table if the coords are 'on' the table" do
    expect(@testbot.place(1,3,'N')).to eql(true)
  end

  it "will default to be facing North if the attribute for 'facing' is ambiguous" do
    @testbot.place(1,3,'X')
    expect(@testbot.report).to eql("(1,3,N)")
  end

  it "updates its position when it moves" do
    @testbot.place(1,1,'N')
    @testbot.move
    expect(@testbot.report).to eql("(1,2,N)")
  end

  it "updates its direction when it turns" do
    @testbot.place(1,1,'N')
    @testbot.turn('left')
    expect(@testbot.report).to eql("(1,1,W)")
  end

  it "refuses to move off the table" do
    @testbot.place(0,0,'S')
    @testbot.move
    expect(@testbot.report).to eql("(0,0,S)")
  end
end