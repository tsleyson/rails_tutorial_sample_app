require 'spec_helper'

describe Micropost do
  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatic....
    #@micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
    # ...because we should create posts through the owning user
    # object. Then it automatically has the right id.
    @micropost = user.microposts.build do |mp|
      mp.content = "Lorem ipsum"
    end
    # For some unfathomable reason, passing in a hash to set the
    # content doesn't work. Doing this block initialization works, and
    # so does just making the object and doing @micropost.content =.
  end
  subject { @micropost }

  it { should respond_to :content }
  it { should respond_to :user_id }
  it { should respond_to :user }
  its(:user) { should eq user }

  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a"*171 }
    it { should_not be_valid }
  end
end
