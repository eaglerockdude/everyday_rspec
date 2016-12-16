require 'rails_helper'

describe Contact do

  it "is valid with a firstname, lastname, and email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname:  'Summer',
      email: 'tester@example.com')
    expect(contact).to be_valid
  end

  it "is invalid without a firstname"   do
    contact = Contact.new(firstname:nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end


  # factory girl version
  it "factory girl - is invalid without a first name" do
    contact = build(:contact,firstname:nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without lastname"  do
    contact = Contact.new(lastname:nil)
    contact.valid?
    expect(contact.errors[:lastname]).to  include("can't be blank")
  end

  it "is invalid without an email address"  do
    contact = Contact.new(email:nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
     # create validates and saves to the database vs. new which just creates.
     # Contact.create(firstname: 'Joe', lastname: 'Tester', email: 'tester@example.com')
     create(:contact,email:'tester@example.com')

     contact = Contact.new(firstname: 'Jane', lastname: 'Tester', email: 'tester@example.com')
     contact.valid?
     expect(contact.errors[:email]).to include("has already been taken")
  end

 # INSTANCE METHOD test
  it "returns a contact's first and last name as a full string" do
    contact = Contact.new(
        firstname:'Ken',
        lastname:'McFadden')

      expect(contact.name).to eq 'Ken McFadden'
  end


  # CLASS  METHOD test - the Contact Model

  it "returns a sorted array of results that match" do
    smith = Contact.create(
        firstname: 'John',
        lastname: 'Smith',
        email: 'jsmith@example.com'
    )

    jones = Contact.create(
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example.com')

    johnson = Contact.create(
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com')

    expect(Contact.by_letter("J")).to eq [johnson, jones]
  end

  it "omits results that do not match" do
    smith = Contact.create(
        firstname: 'John',
        lastname: 'Smith',
        email: 'jsmith@example.com')
    jones = Contact.create(
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example.com')
    johnson = Contact.create(
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com')

    expect(Contact.by_letter("J")).not_to include smith
  end

  # some refactoring DRY  (same tests as above but made DRY)
  # we use a CONTEXT BLOCK and a BEFORE hook:
  # the before executes before each test for only within the Describe block.
  # difference - we now have to assign the contacts to an instance variable @
  # so they will be available outside the block.  Before we did not have to do that.

  describe 'filter last name by letter'   do

    before :each do
      @smith = Contact.create(
          firstname: 'John',
          lastname: 'Smith',
          email: 'jsmith@example.com'
      )
      @jones = Contact.create(
          firstname: 'Tim',
          lastname: 'Jones',
          email: 'tjones@example.com'
      )
      @johnson = Contact.create(
          firstname: 'John',
          lastname: 'Johnson',
          email: 'jjohnson@example.com'
      )
    end

    context 'matching letters ' do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    context 'non-matching letters' do
      it "omits results that do not match" do
        expect(Contact.by_letter("J")).not_to include @smith
      end
    end

  end

  # FACTORY GIRL - does factory girl create a valid contact?
  it 'has a valid factory'  do
    expect(FactoryGirl.build(:contact)).to be_valid
    expect(build(:contact)).to be_valid
  end

  it 'has three phone numbers when createdgit' do
    expect(create(:contact).phones.count).to eq 3
  end

end