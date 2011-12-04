class UserObserver < ActiveRecord::Observer
  def after_save(user)
    Preference.create(:user => user)
  end
end
