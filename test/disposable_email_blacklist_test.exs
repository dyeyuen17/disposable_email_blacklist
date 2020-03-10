defmodule DisposableEmailBlacklistTest do
  use ExUnit.Case
  doctest DisposableEmailBlacklist

  test "Returns true when given email is not included in blacklist" do
    assert DisposableEmailBlacklist.valid?("my_email@gmail.com") == true
  end

  test "Returns false when given email is included in blacklist" do
    assert DisposableEmailBlacklist.valid?("my_email@dispostable.com") == false
  end

  test "Returns true when given email is not included in custom blacklist" do
    custom_blacklist = ["hammermail.tk", "blastmail.org"]
    assert DisposableEmailBlacklist.valid?("my_email@gmail.com", custom_blacklist) == true
  end

  test "Returns false when given email is included in custom blacklist" do
    custom_blacklist = ["hammermail.tk", "blastmail.org"]
    assert DisposableEmailBlacklist.valid?("my_email@hammermail.tk", custom_blacklist) == false
  end
end
