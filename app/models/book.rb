class Book < ActiveRecord::Base
  validates :title, :presence => true
  validates :author, :presence => true
  validates :year, :presence => true, :numericality => { :only_integer => true }
  validates :cover, :presence => true
  
  def self.find_using_filter paramFilter
    if paramFilter == :wish_list.to_s
      return self.where("hasebook = ? AND hascopy = ?", false, false)
    elsif paramFilter == :to_read.to_s
      return self.where("hasread = ? AND (hasebook = ? OR hascopy = ?)", false, true, true)
    elsif paramFilter == :owned.to_s
      return self.where("hasebook = ? OR hascopy = ?", true, true)
    elsif paramFilter == :read.to_s
      return self.where("hasread = ?", true)
    end
    return self.all
  end
end
