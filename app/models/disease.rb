class Disease < ApplicationRecord
  validates :category,  presence: true

  # These are used in the disease form but now no database columns, so create these
  # methods
  attr_accessor :name
  attr_accessor :description

  has_one :disease_description, dependent: :destroy
  # This will give me the methods:
  # disease_description.disease - return the disease associated with the description
  # disease.disease_description - returns a collection (number of one) of
  #  description from the disease
  # disease.disease_description.create(arguments) - creates a
  #     description object associated with a disease
  # disease.disease_description.find_by(id: 1) - finds a disease_


  # Items per pagination page for the Disease object
  self.per_page = 10

  def self.sort_by_description(current_page, per_page)
    disease_id_list = DiseaseDescription.reorder('name ASC').pluck(:disease_id)
    diseases_unpaginated = self.all
    diseases = []
    disease_id_list.each do |id|
      disease = diseases_unpaginated.find(id)
      diseases << disease
    end
    # if don't specify return will return the disease_id_list instead
    length = diseases.length
    diseases = WillPaginate::Collection.create(current_page, per_page, length) do |pager|
      pager.replace diseases[pager.offset, pager.per_page].to_a
    end
    return diseases
  end

  def self.sort_by_description_no_paginate
    disease_id_list = DiseaseDescription.reorder('name ASC').pluck(:disease_id)
    diseases_unpaginated = self.all
    diseases = []
    disease_id_list.each do |id|
      # If do:
      # disease = diseases_unpaginated.find(id)
      # this will work but treats diseases_unpaginated as an ActiveRecord object
      # and will access Disease database not the array of hashes each time loop
      # is run
      disease = diseases_unpaginated.find{|hash| hash[:id] == id}
      diseases << disease
    end
    return diseases
  end

end
