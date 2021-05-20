# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :bookmarks

  validates_presence_of :title, :overview
  validates :title, uniqueness: true
end
