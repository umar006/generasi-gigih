require_relative './who_like_it'

describe WhoLikeIt do
  it "no one likes this" do
    wli = WhoLikeIt.new
    likes = wli.likes
    expect(likes).to eq("no one likes this")
  end

  it "one likes" do
    wli = WhoLikeIt.new
    wli.names = ["Peter"]
    likes = wli.likes
    expect(likes).to eq("Peter likes this")
  end

  it "less than 4 likes" do
    wli = WhoLikeIt.new
    wli.names = ["Jacob", "Alex"]
    likes = wli.likes
    expect(likes).to eq("Jacob and Alex like this")
    wli.names = ["Max", "John", "Mark"]
    likes = wli.likes
    expect(likes).to eq("Max, John and Mark like this")
  end

  it "more than 4 or equals to likes" do
    wli = WhoLikeIt.new
    wli.names = ["Alex", "Jacob", "Mark", "Max"]
    likes = wli.likes
    expect(likes).to eq("Alex, Jacob and 2 others like this")
  end
end