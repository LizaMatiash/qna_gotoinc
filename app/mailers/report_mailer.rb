class ReportMailer < ApplicationMailer

  def report(user, answer)
    @user = user
    @answer = answer
    @question = answer.question

    mail(to: user.email, subject: 'New answer')
  end
end
