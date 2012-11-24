class Notification < ActionMailer::Base
  default from: "recruters@gentoo.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.signup.subject
  #
  def signup(user)
    @user = user
    #mail to: "recruiters@gentoo.org", subject: "New user signup Gentoo Recruiting"
    mail to: "isaiah.peng@vcint.com", subject: "New user signup Gentoo Recruiting"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.ready.subject
  #
  def ready(user)
    @user = user
    mail to: "recruiters@gentoo.org", subject: "#{user.name} is graduating."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.accept.subject
  #
  def accept(user)
    mail to: user.email, subject: "Congrats! You are accepted as a Gentoo developer!"
  end
end
