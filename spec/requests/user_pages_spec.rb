require 'spec_helper'

describe "UserPages" do
  subject {page}

  describe "SignUp page" do
    before { visit signup_path}
    let(:submit) { "Create my account" }

    describe "with invalid info" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it {should have_title('Sign up')}
        it {should have_content('error')}
      end

      describe "after submission with incorrect email" do
        before do
          fill_in "Name", with: "Example User"
          fill_in "Email", with: "user@excom"
          fill_in "Password", with: "foobar"
          fill_in "Confirmation", with: "foobar"
          click_button submit
        end

        it {should have_title('Sign up')}
        it {should have_content('error')}
      end
    end

    describe "with valid info" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@ex.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@ex.com') }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end

  end

  describe "User profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before {visit user_path(user)}

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end


end
