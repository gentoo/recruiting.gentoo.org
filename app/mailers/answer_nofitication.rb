class AnswerNotification < ActionMailer::Base
  default from: "recruiters@gentoo.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.answer.accept.subject
  #
  def accept(user, answer)
    @greeting = "Hi"

    mail to: user.email, subject: "You answer for #{answer.question.name} is accepted."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.answer.reject.subject
  #
  def reject(user, answer)
    @greeting = "Hi"

    mail to: user.email, subject: "You answer for #{answer.question.name} is rejected."
  end
end
