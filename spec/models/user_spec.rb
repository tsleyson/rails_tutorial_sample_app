require 'spec_helper'

describe User do
  before { @user = User.new(name: "The Fat One", email: "tfo@cryptid.ribs",
                            password: "cupsrule", password_confirmation: "cupsrule") }
  subject { @user }

  it { should respond_to :name }
  # it must be a function that executes the given code block
  # using subject as the target of the method calls.
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :authenticate }
  
  it { should be_valid }

  shared_examples_for "all field presence verifications" do
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @user.name = "" }
    it_should_behave_like "all field presence verifications"
  end
  
  describe "when email is not present" do
    before { @user.email = "" }
    it_should_behave_like "all field presence verifications"
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com 
                     foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid|
        @user.email = valid
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  describe "when database records are saved" do
    it "should make the email lowercase" do
      @user.email = "UPPERCASE@ANGRY.COM"
      @user.save
      expect(@user.reload.email).to eq "uppercase@angry.com"
    end
  end

  describe "when password is blank" do
    before do
      @user = User.new(name: "Blankety blankson", email: "blank@blank.blank",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    # find_by only in Rails 4.
    # let(:found_user) { User.find_by(:email => @user.email) }
    let(:found_user) { User.find_by_email(@user.email) }
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end
    describe "with invalid password" do
      let(:user_with_invalid_password) { found_user.authenticate "invalid" }
      it { should_not eq user_with_invalid_password }
      specify { expect(user_with_invalid_password).to be_false }
    end

    describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end
  end
end
