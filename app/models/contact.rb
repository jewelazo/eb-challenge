class Contact < ApplicationRecord
    validate :at_least_one_data_contact
end

private
def at_least_one_data_contact
    return if name || phone || email

    errors.add(:base,"You must specify a contact source")
end