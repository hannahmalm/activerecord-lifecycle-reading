class Post < ActiveRecord::Base

  belongs_to :author
  validate :is_title_case 

  #new code
  #this validation happens before a callback
  #before that first our before_validation code works, which title cases the title, then the validation runs
  #WHENEVER YOU ARE MODIFYING AN ATTRIBUTE OF THE MODEL, USE BEFORE VALIDATION
  before_validation :make_title_case

  #WHENEVER YOU ARE DOING SOME OTHER ACTION, USE BEFORE SAVE
  #actions that need to occure that aren't modifying the model itself
  #ex: whenever you save to the daatabase, send an email to the Author alerting them that the post was saved
  before_save :email_author_about_post

  #before_create - this only gets called when a model is created for the first time

  private

  #this validation is used to ensure that the title starts with a capital letter
  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def email_author_about_post
    #Not implimented here
  end

  def make_title_case
    #rails provides a String#titlecase method
    self.title = self.title.titlecase
  end
end
