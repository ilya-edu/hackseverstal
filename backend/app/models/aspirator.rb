class Aspirator < ApplicationRecord
  belongs_to :sinter_machine, optional: true
  has_many :signal_kinds
  # has_many :signal_values, through: :signal_kinds

  def status
    :ok
  end

end
