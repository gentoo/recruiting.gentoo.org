class AnswerNotification < ActionMailer::Base
  default from: "noreply@recruiting.gentoo.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.answer.accept.subject
  #
  def accept(user, answer)
    @greeting = "Hi"

    mail to: user.email, subject: "You answer for #{answer.question.title} is accepted."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.answer.reject.subject
  #
  def reject(user, answer)
    @greeting = "Hi"

    mail to: user.email, subject: "You answer for #{answer.question.title} is rejected."
  end

  def update(user, answer)
    @greeting = "Hi"

    mail to: user.mentors.map(&:email), subject: "#{user.name} update his answer for quetion #{answer.question.title}."
  end

  def new(user, answer)
    @greeting = "Hi"

    mail to: user.mentors.map(&:email), subject: "#{user.name} answered quetion #{answer.question.title}."
  end
end
