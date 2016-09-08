class AdminMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  default from: 'notification@videorehearser.com'
  
  def new_user_waiting_for_approval
    @url  = 'https://videorehearser.herokuapp.com/users/sign_in'
    mail(to: 'roger.rodriguez666@gmail.com', subject: "New User Signup")
  end

  def user_register_notice(user)
    @user = user
    @url = 'https://videorehearser.herokuapp.com/users/sign_in'
    mail( to: @user.email, subject: "Welcome to VR!")
  end
end