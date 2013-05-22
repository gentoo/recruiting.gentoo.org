class Notification < ActionMailer::Base
  default from: "no-reply@recruiting.gentoo.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.signup.subject
  #
  def signup(user)
    @user = user
    mail to: "recruiters@gentoo.org", subject: "New user signup Gentoo Recruiting"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.ready.subject
  #
  def ready(user)
    @user = user
    #FIXME fix this once multiple subscription is done
    @quiz_type = user.user_groups.first.name
    @url = candidate_answers_url(candidate:user)
    mail to: "recruiters@gentoo.org", subject: "#{user.name} is graduating."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.accept.subject
  #
  def accept(recruiter, user)
    @user = user
    @recruiter = recruiter
    mail to: user.email, subject: "Congratulations! You are accepted as a Gentoo developer!"
  end

  def recruit(recruiter, user, mentors)
    @user = user
    @recruiter = recruiter
    mail to: mentors.map(&:email), subject: "Your mentee #{user.name} was accepted as a Gentoo developer."
  end
end
