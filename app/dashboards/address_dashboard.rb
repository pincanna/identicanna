require "administrate/base_dashboard"

class AddressDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    verification_code: Field::String,
    first_name: Field::String,
    last_name: Field::String,
    line1: Field::String,
    line2: Field::String,
    city: Field::String,
    state: Field::String,
    zip: Field::String,
    letter_id: Field::String,
    letter_status: Field::String,
    # letter: Field::String.with_options(searchable: false),
    letter: Field::Jsontable,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :verification_code,
    :first_name,
    :last_name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :verification_code,
    :first_name,
    :last_name,
    :line1,
    :line2,
    :city,
    :state,
    :zip,
    :letter_id,
    :letter_status,
    :letter,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :verification_code,
    :first_name,
    :last_name,
    :line1,
    :line2,
    :city,
    :state,
    :zip,
    :letter_id,
    :letter_status,
    :letter,
  ].freeze

  # Overwrite this method to customize how addresses are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(address)
  #   "Address ##{address.id}"
  # end
end
