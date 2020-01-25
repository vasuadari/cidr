defmodule CIDRTest do
  use ExUnit.Case, async: true

  describe "parse/1" do
    test "returns CIDR struct" do
      assert {
               :ok,
               %CIDR{
                 last_address: "172.22.0.255",
                 subnet_mask: "255.255.255.0",
                 class: :C,
                 hosts: 256
               }
             } == CIDR.parse("172.22.0.0/24")
    end

    test "returns error when CIDR notation is invalid" do
      assert {:error, :invalid} == CIDR.parse("172.22.0.0.24")
    end

    test "returns error when CIDR notation contains alphabet" do
      assert {:error, :invalid} == CIDR.parse("a.22.0.0/24")
    end

    test "returns error when input is random string" do
      assert {:error, :invalid} == CIDR.parse("a")
    end
  end
end
