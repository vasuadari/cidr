defmodule CIDR.CalculatorTest do
  use ExUnit.Case, async: true
  doctest CIDR.Calculator

  alias CIDR.Calculator

  describe "no_of_hosts/1" do
    test "returns 256 for /24 CIDR" do
      assert 256 == Calculator.no_of_hosts(24)
    end

    test "returns 65,536 for /16 CIDR" do
      assert 65_536 == Calculator.no_of_hosts(16)
    end

    test "returns 1 for /32 CIDR" do
      assert 1 == Calculator.no_of_hosts(32)
    end
  end

  describe "subnet_mask/1" do
    test "returns 255.255.255.255 for /32 CIDR" do
      assert <<255, 255, 255, 255>> == Calculator.subnet_mask(32)
    end

    test "returns 255.255.255.0 for /24 CIDR" do
      assert <<255, 255, 255, 0>> == Calculator.subnet_mask(24)
    end

    test "returns 255.255.255.0 for /21 CIDR" do
      assert <<255, 255, 248, 0>> == Calculator.subnet_mask(21)
    end

    test "returns 255.248.0.0 for /13 CIDR" do
      assert <<255, 248, 0, 0>> == Calculator.subnet_mask(13)
    end

    test "returns 255.128.0.0 for /9 CIDR" do
      assert <<255, 128, 0, 0>> == Calculator.subnet_mask(9)
    end

    test "returns 128.0.0.0 for /1 CIDR" do
      assert <<128, 0, 0, 0>> == Calculator.subnet_mask(1)
    end
  end

  describe "class/1" do
    test "returns A for /8 CIDR" do
      assert :A == Calculator.class(8)
    end

    test "returns A for /0 CIDR" do
      assert :A == Calculator.class(0)
    end

    test "returns B for /16 CIDR" do
      assert :B == Calculator.class(16)
    end

    test "returns B for /9 CIDR" do
      assert :B == Calculator.class(9)
    end

    test "returns C for /32 CIDR" do
      assert :C == Calculator.class(32)
    end

    test "returns C for /17 CIDR" do
      assert :C == Calculator.class(17)
    end
  end

  describe "last_address/1" do
    test "returns 0.0.0.255 for /24 CIDR" do
      assert <<0, 0, 0, 255>> == Calculator.last_address(24)
    end

    test "returns 0.0.7.255 for /21 CIDR" do
      assert <<0, 0, 7, 255>> == Calculator.last_address(21)
    end

    test "returns 0.7.255.255 for /13 CIDR" do
      assert <<0, 7, 255, 255>> == Calculator.last_address(13)
    end

    test "returns 0.127.255.255 for /9 CIDR" do
      assert <<0, 127, 255, 255>> == Calculator.last_address(9)
    end

    test "returns 127.255.255.255 for /1 CIDR" do
      assert <<127, 255, 255, 255>> == Calculator.last_address(1)
    end
  end

  describe "last_address/2" do
    test "returns 172.22.0.1 for /32 CIDR" do
      assert <<172, 22, 0, 1>> ==
               Calculator.last_address(
                 {172, 22, 0, 1},
                 32
               )
    end

    test "returns 172.22.0.255 for /24 CIDR" do
      assert <<172, 22, 0, 255>> ==
               Calculator.last_address(
                 {172, 22, 0, 0},
                 24
               )
    end

    test "returns 172.22.255.255 for /16 CIDR" do
      assert <<172, 22, 255, 255>> ==
               Calculator.last_address(
                 {172, 22, 0, 0},
                 16
               )
    end

    test "returns 172.255.255.255 for /8 CIDR" do
      assert <<172, 255, 255, 255>> ==
               Calculator.last_address(
                 {172, 0, 0, 0},
                 8
               )
    end
  end
end
