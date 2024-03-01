require "rails_helper"

describe "Rangeable", type: :model do
  describe "#value" do
    context "given an integer" do
      it "returns the integer" do
        expect(Rangeable.new(13).value).to eq 13
      end
    end

    context "given a float" do
      it "returns the float" do
        expect(Rangeable.new(12.5).value).to eq 12.5
      end
    end

    context "given an integer as a string" do
      [
        "13",
        " 13 ",
        " 13",
        "13 "
      ].each do |raw_value|
        it "returns the integer" do
          expect(Rangeable.new(raw_value).value).to eq 13
        end
      end
    end

    context "given an single digit integer as a string" do
      [
        "8",
        " 8 ",
        " 8",
        "8 "
      ].each do |raw_value|
        it "returns the integer" do
          expect(Rangeable.new(raw_value).value).to eq 8
        end
      end
    end

    context "given a float as a string" do
      [
        "12.5",
        " 12.5 ",
        " 12.5",
        "12.5 "
      ].each do |raw_value|

        it "returns the float" do
          expect(Rangeable.new(raw_value).value).to eq 12.5
        end
      end
    end

    context "given a target value" do
      [
        "@7",
        " @7 ",
        " @7",
        "@7 "
      ].each do |raw_value|

        it "returns the target value as a string" do
          expect(Rangeable.new(raw_value).value).to eq "@7"
        end
      end
    end

    context "given a range string" do
      [
        "10-20",
        " 10-20 ",
        "  10-20  ",
        "  10-20",
        "10-20",
        "10 - 20",
        "10- 20",
        "10 -20",
        "10  - 20",
        "10 to 20",
        "10to20",
        "10..20",
        "10...21"
      ].each do |raw_value|
        it "returns a range" do
          expect(Rangeable.new(raw_value).value).to eq 10..20
        end
      end
    end
  end

  describe "#database_value" do
    context "given an integer" do
      it "returns the integer" do
        expect(Rangeable.new(13).database_value).to eq 13..13
      end
    end

    context "given a float" do
      it "returns the float" do
        expect(Rangeable.new(12.5).database_value).to eq 12.5..12.5
      end
    end

    context "given an integer as a string" do
      [
        "13",
        " 13 ",
        " 13",
        "13 "
      ].each do |raw_value|
        it "returns the integer" do
          expect(Rangeable.new(raw_value).database_value).to eq 13..13
        end
      end
    end

    context "given an single digit integer as a string" do
      [
        "8",
        " 8 ",
        " 8",
        "8 "
      ].each do |raw_value|
        it "returns the integer" do
          expect(Rangeable.new(raw_value).database_value).to eq 8..8
        end
      end
    end

    context "given a float as a string" do
      [
        "12.5",
        " 12.5 ",
        " 12.5",
        "12.5 "
      ].each do |raw_value|

        it "returns the float" do
          expect(Rangeable.new(raw_value).database_value).to eq 12.5..12.5
        end
      end
    end

    context "given a target value" do
      [
        "@7",
        " @7 ",
        " @7",
        "@7 "
      ].each do |raw_value|

        it "returns the target value as a string" do
          expect(Rangeable.new(raw_value).database_value).to eq 7..7
        end
      end
    end

    context "given a range string" do
      [
        "10-20",
        " 10-20 ",
        "  10-20  ",
        "  10-20",
        "10-20",
        "10 - 20",
        "10- 20",
        "10 -20",
        "10  - 20",
        "10 to 20",
        "10to20",
        "10..20",
        "10...21"
      ].each do |raw_value|
        it "returns a range" do
          expect(Rangeable.new(raw_value).database_value).to eq 10..20
        end
      end
    end
  end

  describe "#type" do
    subject { Rangeable.new(raw_value).type }

    context "given an integer" do
      it "returns 'target'" do
        expect(Rangeable.new(13).type).to eq "target"
      end
    end

    context "given a float" do
      it "returns 'target'" do
        expect(Rangeable.new(12.5).type).to eq "target"
      end
    end

    context "given an integer as a string" do
      [
        "13",
        " 13 ",
        " 13",
        "13 "
      ].each do |raw_value|
        it "returns 'target'" do
          expect(Rangeable.new(raw_value).type).to eq "target"
        end
      end
    end

    context "given an single digit integer as a string" do
      [
        "8",
        " 8 ",
        " 8",
        "8 "
      ].each do |raw_value|
        it "returns 'target'" do
          expect(Rangeable.new(raw_value).type).to eq "target"
        end
      end
    end

    context "given a float as a string" do
      [
        "12.5",
        " 12.5 ",
        " 12.5",
        "12.5 "
      ].each do |raw_value|
        it "returns 'target'" do
          expect(Rangeable.new(raw_value).type).to eq "target"
        end
      end
    end

    context "given a target value" do
      [
        "@7",
        " @7 ",
        " @7",
        "@7 "
      ].each do |raw_value|
        it "returns 'limit'" do
          expect(Rangeable.new(raw_value).type).to eq "limit"
        end
      end
    end

    context "given a range string" do
      [
        "10-20",
        " 10-20 ",
        "  10-20  ",
        "  10-20",
        "10-20",
        "10 - 20",
        "10- 20",
        "10 -20",
        "10  - 20",
        "10 to 20",
        "10to20",
        "10..20",
        "10...21"
      ].each do |raw_value|
        it "returns 'range'" do
          expect(Rangeable.new(raw_value).type).to eq "range"
        end
      end
    end
  end
end
