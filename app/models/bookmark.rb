# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  validates_uniqueness_of :movie_id, scope: :list_id
  validates :comment, length: { minimum: 6 }
  validates_presence_of :movie_id, :list_id
end
