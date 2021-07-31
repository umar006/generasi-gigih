require_relative './martabak'

describe Martabak do
  it "is delicious" do
    martabak = Martabak.new("cokelat")
    taste = martabak.taste
    expect(taste).to eq("martabak coklat is delicious")
  end
end