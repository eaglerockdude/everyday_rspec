require 'rails_helper'

describe Phone do

  it "does not allow duplicate phone numbers per contact" do
=begin
    contact = Contact.create(
        firstname: 'Joe',
        lastname:'Tester',
        email:'joetester@example.com')
=end

    # here we dry up the specs some defining phone types in the factory:
    contact = create(:contact)

    create(:home_phone, contact:contact,phone:'123-456-7890')

    mobile_phone = build(:mobile_phone, contact:contact, phone:'123-456-7890')

    mobile_phone.valid?

      expect(mobile_phone.errors[:phone]).to include('has already been taken')
  end

  it "allows two contacts to share a phone number" do

    # contact = Contact.create(            (old code not using factory)
    #     firstname: 'Joe',
    #     lastname:'Tester',
    #     email:'joetester@example.com')

    contact = create(:contact)      # using factory

    contact.phones.create(
        phone_type:'home',
        phone:'123-456-7890')

    other_contact = Contact.new

    other_phone = other_contact.phones.build(
        phone_type: 'home',
        phone: '123-456-7890')

      expect(other_phone).to be_valid

  end

  # FACTORY GIRL - does factory girl create a valid phonet?
  it 'phone has a valid factory'  do
    expect(FactoryGirl.build(:phone)).to be_valid
  end



end