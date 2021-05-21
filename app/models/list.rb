# frozen_string_literal: true

class List < ApplicationRecord
  has_one_attached :photo
  has_many :bookmarks
  has_many :movies, through: :bookmarks, dependent: :destroy

  validates :name, uniqueness: {case_sensitive: false}, presence: true

end
